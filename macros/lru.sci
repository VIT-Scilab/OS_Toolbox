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
function [pos] = findLRU(time, n)
    pos = 1;
    minimum = time(1);
    
    for i = 1:n
        if time(i) < minimum
            minimum = time(i);
            pos = i;
        end
    end
endfunction

function [faults] = lru(no_frames, no_pages, ref_string, p)
    flag1 = 0;
    flag2 = 0;
    counter = 0;
    faults = 0;
    frames = [];
    time = [];
    
    if ~exists("p","local") then
        p = 0
    end
    
    for i = 1:no_frames
        frames(i) = -1;
    end
    
    for i = 1:no_pages
        flag1 = 0;
        flag2 = 0;
        
        for j = 1:no_frames
            if (frames(j) == ref_string(i))
                counter = counter + 1;
                time(j) = counter;
                flag1 = 1;
                flag2 = 1;
                break;
            end
        end
        
        if flag1 == 0
            for j = 1:no_frames
                if frames(j) == -1
                    counter = counter + 1;
                    faults = faults + 1;
                    frames(j) = ref_string(i);
                    time(j) = counter;
                    flag2 = 1;
                    break;
                end
            end
        end
        
        if flag2 == 0
            pos = findLRU(time, no_frames)
            counter = counter + 1;
            faults = faults + 1;
            frames(pos) = ref_string(i);
            time(pos) = counter;
        end
        
        if p == 1 then
            mprintf("\n");
            for j = 1:no_frames
                mprintf("%d\t", frames(j));
            end
        end
        
    end
    if p == 1 then
        mprintf("\n\nTotal Page Faults = %d \n\n", faults);
    end
    
endfunction
