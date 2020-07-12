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
// Function to sort the processes in the order of arrival time
function [] = sort_processes(pro,at,bt,n)
    for i=2:n
        j=i-1;
        key1 = pro(i);
        key2 = at(i);
        key3 = bt(i);
        while j>=1 && key2 < at(j)
            at(j+1) = at(j);
            bt(j+1) = bt(j);
            pro(j+1) = pro(j);
            j = j-1;
        end
           pro(j+1) = key1;
           at(j+1) = key2;
           bt(j+1) = key3;
    end
endfunction

function [sum_turnaround,sum_wait] = rr(at,bt,n,time_quantum,p)
    if ~exists("p","local") then
        p = 0
    end
    sum_turnaround = 0;
sum_wait = 0;
t = 0;
    for i=1:n
        pro(i) = i;
    end
    sort_processes(pro,at,bt,n)
    for i=1:n
        rt(i) = bt(i);
    end
    sum_wait = at(1);
    if p==1 then
        mprintf("\n\nProcess     Arrival Time      Burst Time      Completion Time      Turnaround Time     Waiting Time\n")
    end
            // Preemption Of processes and calculate completion time
        temp = n;
        time = 0;
        while temp ~= 0
            for i=1:n
                if (rt(i) <= time_quantum && rt(i) > 0) then 
                time = time + rt(i);
                rt(i) = 0;
                t = 1;
                end
                if rt(i) > 0 then
                    rt(i) =rt(i) - time_quantum;
                    time = time_quantum + time
                end
            if rt(i) == 0 && t == 1 then
                temp = temp -1;
                if p==1 then
                mprintf("P%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t\t%d\n",pro(i),at(i),bt(i),time,time-at(i),time-at(i)-bt(i))
                end
                // Calculate Average Wait and Turnaround Time
                sum_wait  = sum_wait + time -at(i) -bt(i);
                sum_turnaround  = sum_turnaround + time -at(i);
                t=0;
            end
            // Round Robin coming back to the left over processes
            if i == n-1 then 
                i = 1;
            end
            if at(i) <= time then
                i = i+1;
            else
                i = 1;
            end
        end
    end
    if  p==1 then
        mprintf("\nAvg Waiting Time = %f\n",sum_wait*1.0/n)
 mprintf("Avg Turn Around Time = %f",sum_turnaround*1.0/n)
    end
 
endfunction       
