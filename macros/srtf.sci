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
function [turnaround, waiting] = srtf(n, a, b, p)
    for i = 1:n 
        x(i) = b(i)
    end

    b(9) = 9999
    time = 0 
    count = 0
    
    if ~exists("p","local") then
        p = 0
    end
    
    while count ~= n 
        smallest = 9 
        time = time + 1
        

        for i = 1:n
            if (a(i) <= time) & (b(i) < b(smallest)) & (b(i) > 0)  
                then smallest = i
            end
        end
        b(smallest) = b(smallest) - 1 
        
        if b(smallest) == 0 then 
            count = count + 1
            end1 = time + 1
            completion1(smallest) = end1 
            waiting(smallest) = end1 - a(smallest) - x(smallest)
            turnaround(smallest) = end1 - a(smallest)    
        end    
    end
    
    avg_wt = 0
    avg_tt = 0
    for i = 1:n
        avg_wt = avg_wt + waiting(i)
        avg_tt = avg_tt + turnaround(i) 
    end
    
    avg_wt = avg_wt/n 
    avg_tt = avg_tt/n 
    
    if p == 1 then
        mprintf("\Process\tArrival Time\tBurst Time\tWaiting Time\tTurnaround Time\tCompletion Time \n")
        for i=1:n
            mprintf("   %d \t     %d \t\t      %d \t      %d \t        %d \t        %d \n", i, a(i), x(i), waiting(i), turnaround(i), completion1(i)) 
        end
        
        mprintf("\nThe average Waiting Time is: %.2f \t The average Turnaround Time is: %.2f \n\n", avg_wt, avg_tt)
    end
    
endfunction
