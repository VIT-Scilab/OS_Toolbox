/*****************************************************************************
Copyright © 2020 

Authors: Surya Prasad S, Yeshwanth R, Tharun Bhargav A, Aravind Krishna R, Dr. Maheswari R
Organization: VIT Chennai
Email: suryavirat09@gmail.com, yeshwa.rp@gmail.com, tharun.cam@gmail.com, aravind2000krishna@gmail, maheswari.r@vit.ac.in 

This file must be used under the terms of CeCILL. This source file is licensed as described in the file LICENSE, 
which you should have received as part of this distribution.  The terms are also available at
https://cecill.info/licences/Licence_CeCILL_V2-en.txt 

This software is governed by the CeCILL  license under French law and
abiding by the rules of distribution of free software.  You can  use, 
modify and/ or redistribute the software under the terms of the CeCILL
license as circulated by CEA, CNRS and INRIA at the following URL
"http://www.cecill.info". 

As a counterpart to the access to the source code and  rights to copy,
modify and redistribute granted by the license, users are provided only
with a limited warranty  and the software's author,  the holder of the
economic rights,  and the successive licensors  have only  limited
liability. 

In this respect, the user's attention is drawn to the risks associated
with loading,  using,  modifying and/or developing or reproducing the
software by the user in light of its specific status of free software,
that may mean  that it is complicated to manipulate,  and  that  also
therefore means  that it is reserved for developers  and  experienced
professionals having in-depth computer knowledge. Users are therefore
encouraged to load and test the software's suitability as regards their
requirements in conditions enabling the security of their systems and/or 
data to be ensured and,  more generally, to use and operate it in the 
same conditions as regards security. 

The fact that you are presently reading this means that you have had
knowledge of the CeCILL license and that you accept its terms.
**********************************************************************************/
function [tat1,tat2,tat3]=mqueue(n,at,bt,p)
    Q1=[],Q2=[],Q3=[];
//n=input("Enter no of processes in HIGHEST PRIORITY queue");
 if ~exists("p","local") then
    p = 0
     end
for i=1:n
 Q1(i)=struct('pid',i,'AT',at(i),'BT',bt(i),'TAT',0,'WT',0,'RT',bt(i),'CT',0); 
 Q2(i)=struct('pid',0,'AT',0,'BT',0,'TAT',0,'WT',0,'RT',0,'CT',0);
 Q3(i)=struct('pid',0,'AT',0,'BT',0,'TAT',0,'WT',0,'RT',0,'CT',0);
                      //save INITIAL remaining time as burst time for each process
end
r=1,time=0,tq1=5,tq2=8,flag=0,k=1,wt=0,tat=0;

//Sorting based on arrival time
for i=1:n
 for j=i+1:n
 if Q1(i).AT > Q1(j).AT then
 tmp=Q1(i);
 Q1(i)=Q1(j);
 Q1(j)=tmp;
 end
 end
end
time=Q1(1).AT;
if p==1 then
    mprintf("\nRT-Response time WT-Waiting time TAT-Turnaround time\n\n")
    mprintf("Process in first queue following RR with Time Quantum=5\n");
    mprintf("\nProcess\t\tRT\t\tWT\t\tTAT\t\t");
end

for i=1:n
 if Q1(i).RT<=tq1 then
 time=time+Q1(i).RT;
 Q1(i).RT=0;
 Q1(i).WT=time-Q1(i).AT-Q1(i).BT; /*Calculating Waiting Time of the ith process
in queue Q1*/
 wt=wt+Q1(i).WT;
Q1(i).TAT=time-Q1(i).AT; /*ith process time from arrival to execution
completion*/
tat=tat+Q1(i).TAT;
if p==1 then
mprintf("\n%d\t\t%d\t\t%d\t\t%d",Q1(i).pid,Q1(i).BT,Q1(i).WT,Q1(i).TAT);
end
else /*process moves to queue 2 with qt=8*/
Q2(k).WT=time;
time=time+tq1;
Q1(i).RT=Q1(i).RT-tq1;
Q2(k).BT=Q1(i).RT;
Q2(k).RT=Q2(k).BT;
Q2(k).pid=Q1(i).pid;
k=k+1;
flag=1;
 end
end
if flag==1 then
    if p==1 then
        mprintf("\n\nProcess in second queue following RR with Time Quantum=8\n");
        mprintf("\nProcess\t\tRT\t\tWT\t\tTAT\t\t");
    end
end
for i=1:k-1
 if Q2(i).RT<=tq2 then
 time=time+Q2(i).RT; /*from arrival time of first process +BT of this process*/
 Q2(i).RT=0;
Q2(i).WT=time-tq1-Q2(i).BT;
 wt=wt+Q2(i).WT;
Q2(i).TAT=time-Q2(i).AT;
tat=tat+Q2(i).TAT;
if p==1 then
mprintf("\n%d\t\t%d\t\t%d\t\t%d",Q2(i).pid,Q2(i).BT,Q2(i).WT,Q2(i).TAT);
end
 else/*process moves to queue 3 with FCFS*/
 Q3(r).AT=time;
time=time+tq2;
Q2(i).RT=Q2(i).RT-tq2;
 Q3(r).BT=Q2(i).RT;
Q3(r).RT=Q3(r).BT;
Q3(r).pid=Q2(i).pid; r=r+1; flag=2;
end
end
if(flag==2) then
    if p==1 then
mprintf("\n\nProcess in third queue following FCFS\n");
mprintf("\nProcess\t\tRT\t\tWT\t\tTAT\t\t");
end
end
for i=1:r-1
if i==1 then
Q3(i).CT=Q3(i).BT+time-tq1-tq2;
else Q3(i).CT=Q3(i-1).CT+Q3(i).BT;
end
end
for i=1:r-1
Q3(i).TAT=Q3(i).CT;
tat=tat+Q3(i).TAT;
Q3(i).WT=Q3(i).TAT-Q3(i).BT; 
wt=wt+Q3(i).WT;
if p==1 then
mprintf("\n%d\t\t%d\t\t%d\t\t%d\t\t",Q3(i).pid,Q3(i).BT,Q3(i).WT,Q3(i).TAT);
end
end
tat1=Q1.TAT
tat2=Q2.TAT
tat3=Q3.TAT
if p==1 then
mprintf("\nAVG Waiting time: %f",wt/n);
mprintf("\nAVG Turnaround time: %f",tat/n);
end
endfunction
