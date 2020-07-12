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
function [tatime]=fcfs(num,btime,p)  // Function defintion of first come first serve 
if ~exists("p","local") then
        p = 0
end
t1=0;               // intializing time t1=0 for total waiting time calculation
t2=0;              // intializing time t2=0 for total turn round time calculation

btime         // assigning burst time 
wtime=zeros(1,num)        // assigning waiting time
tatime=zeros(1,num)      // assigning turn around time
n=num;              // assigning number of process n=4 here
fd = %io(2);

 //For loop for calculating total waiting time of each Process 
    for i=2:1:n
     wtime(i)=btime(i-1)+wtime(i-1);  //waiting time will be sum of burst time of previous process and waiting time of previous process
     t1=t1+wtime(i);                  //calculating total waiting time
    end 

//For loop for calculating total turn around time of each Process 
    for i=1:1:n
     tatime(i)=btime(i)+wtime(i);     //turn around time=burst time +wait time
     t2=t2+tatime(i);                 //total turn around time
    end    
    
   
    //displaying the waiting time of each Process 
    if p==1 then
        for i=1:1:n
         mfprintf(fd,'   P%d is %d',i,wtime(i));  
        end 
    disp('Turn-Around Time of each Process');       //displaying the final Turn-Around time of each Process
    for i=1:1:n
        mfprintf(fd,'   P%d is %d',i,tatime(i));
    end
    
    mfprintf(fd,'\n   Average Waiting Time is  %.2f',t1/n);       //displaying the Average waiting time 
    mfprintf(fd,'\n   Average Turn-Around Time  is %.2f',t2/n);   //displaying the Average Turn Around time  
end
endfunction     
