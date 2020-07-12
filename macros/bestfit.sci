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
//**********************************************************************************/
function [bf_allot, bf_allotsize] = bestfit(proc,b, p)
    if ~exists("p","local") then
        p = 0
    end
    size_process = size(proc)(2)
    size_block = size(b)(2)
    bf_allot = zeros(1,size_process);
    bf_flag = zeros(1,size_block);
    for i=1:size_process
        k = -1;           
        for j=1:size_block
            if proc(i)<=b(j) && bf_flag(j) == 0 then 
                if k==-1 then
                    k = j; 
                elseif(b(j)<b(k)) 
                    k = j; 
                end,
            end,         
        end
        if(k==-1)
            bf_allot(i)=0;
        else
            bf_allot(i) = k; 
            bf_flag(k) = 1; 
        end,
    end
    bf_allotsize = zeros(1,size_process);
    for i=1:size_process
        if bf_allot(i)~=0 then
            bf_allotsize(i) = b(bf_allot(i));
        else
            bf_allotsize(i) = -1
            bf_allot(i) = -1
        end,
    end
    if p == 1 then
        mprintf("\nBEST FIT:\n")
        mprintf("Process no. \tProcess size\tBlock no. \tBlock size\n")
        for i=1:size_process
         if bf_allot(i)== -1 then
                mprintf("%d\t\t%d\t\tNot allocated  \t  -\n",i,proc(i))
            else
                mprintf("%d\t\t%d\t\t%d\t\t  %d\n",i,proc(i),bf_allot(i),bf_allotsize(i))
            end,
        end
    end
endfunction



