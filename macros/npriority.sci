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
function [tat,pid]=npriority(n,priority,at,bt,p)
    time=0
    waiting=[]
    response=[]
    tat=[]
    pid=[]
    if ~exists("p","local") then
    p = 0
     end
for i=1:n
 st(i)=struct('priority',priority(i),'at',at(i),'bt',bt(i),'pid',i);
end
//Sorting based on priority
for i=1:n
    for j=i+1:n
        if st(i).priority>st(j).priority
            temp=st(i);
            st(i)=st(j);
            st(j)=temp;
        end     
    end
end
for i= 1:n
    pid(i)=st(i).pid
end
if p==1 then
    mprintf("Gantt chart:\n")
for i=1:n
    
    mprintf("P%d  ",st(i).pid)
end
end
time=st(1).at+st(1).bt
if p==1 then
    mprintf("\npid\t Priority\t Arrival_time\t Burst_time  Completion_time  Turnaround_time  Waiting_time Response_time\n")
end

waiting(1)=time-st(1).at-st(1).bt;
tat(1)=time-st(1).at;
response(1)=waiting(1)+st(1).at;

if p==1 then
    mprintf("P%d\t  %d\t\t\t %d\t\t %d\t\t%d\t\t%d\t\t%d\t%d\n",...
    st(1).pid,st(1).priority,st(1).at,st(1).bt,time,tat(1),waiting(1),response(1));
end

for i=2:n
  if time>=st(i).at then
      time=time+st(i).bt
else
    time_rem=st(i).at-time
    time=time+time_rem+st(i).bt  
end
waiting(i)=time-st(i).at-st(i).bt;
tat(i)=time-st(i).at;
response(i)=waiting(i)+st(i).at;
if p==1 then
mprintf("P%d\t  %d\t\t\t %d\t\t %d\t\t%d\t\t%d\t\t%d\t%d\n",...
        st(i).pid,st(i).priority,st(i).at,st(i).bt,time,tat(i),waiting(i),response(i));
end
end
w=0;tt=0;r=0;
for i=1:n
    w=w+waiting(i)
    tt=tt+tat(i)
    r=r+response(i)
end
if p==1 then
    mprintf("\nAverage Waiting time:%.2f\nAverage Turnaround time:%.2f\n",w/n,tt/n);
    mprintf("Average Response time:%.2f",r/n);
end
endfunction
