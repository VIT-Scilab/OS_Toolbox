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
function [tatime]=sjf(num,pt,p)  // Function defintion of first come first serve 
   if ~exists("p","local") then
        p = 0
   end
n=num     // number of processes
ptime = pt  //process time or burst time
tatime =zeros(1,num)  //turn around time
wtime = zeros(1,num)   //waiting time
fd = %io(2);
total=0;
total2=0;
//Determining the number of processes and blocks
size_process = n;
size_ptime = size(ptime);
size_ptime = size_ptime(2);

//marks the position of process with minimum burst time in the specified range. This may be used to rearrange the order of the processes to achieve proper SJF scheduling...
for i=1:1:n-1   //For loop for sorting the processes in terms of process times
   for j=i+1:1:n
       if(ptime(i)>ptime(j))
           temp=ptime(i);           //temporary variable used to enable efficient swapping of values ..
           ptime(i) = ptime(j);
           ptime(j) = temp;
       end
  end
   
end

 wtime(1) = 0;
 //waiting time calculation
 for i=2:1:n
    wtime(i) = wtime(i-1)+ptime(i-1);   //wait time of a process is sum of wait time of process before it and process time of process before it
    total = total + wtime(i);           //finding total waiting time
end

//total turnaround time calculation
for i=1:1:n
    tatime(i)=ptime(i)+wtime(i);    //turn around time=burst time +wait time
    total2=total2+tatime(i);                //total turn around time
end

avg = total/n;                          //finding average time, average waiting time calculated by dividing total waiting time by number of proceses
avg1 = total2/n;                        //average turn around time calculated by dividing total turn around time by number of processes
if p==1 then
    display(size_process,wtime,tatime,avg,avg1) //displaying the process and block allocation by first fit array
    end      

endfunction
