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
function [tot_seek, seq] = look(head, ar, p)
   if ~exists("p","local") then
        p = 0
   end
   ini_head = head;
   for i=1:size(ar)(2)
        if( ar(i) < head)
            left($+1) = ar(i);
        else 
            right($+1) = ar(i);
        end,
    end
    left = gsort(left,'r' ,'i');
    right = gsort(right,'r' ,'i');
    distance = 0;
    tot_seek = 0;
    for i=1:size(right)(1)
        seq($+1) = right(i);
        distance = right(i) - head;
        tot_seek = distance + tot_seek;
        head = right(i);  
    end 
    tot_seek = tot_seek + (head - left(size(left)(1)));
    head = left(size(left)(1))
    for i=size(left)(1):-1:1
        seq($+1) = left(i);
        distance = head - left(i);
        tot_seek = distance + tot_seek;
        head = left(i);
    end
    if p==1 then
        mprintf("Initial head position = %d\n",ini_head) 
        mprintf("Total seek count = %d\n",tot_seek) 
        mprintf("Seek Sequence is\n")
        for i=1:size(seq)(1)
            mprintf("%d\n",seq(i))
    end
    end
endfunction


