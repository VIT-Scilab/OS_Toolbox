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
lookup=[];
dif=[];
pos=-1;
///////////////////////////////////////////////////////////////
// Function to find the min distance between
// the head position(initial) and other positions.
function [pos, dif, lookup]=mindist(ar, initial, dif, lookup)
for i=1:length(ar)
dif(1,i)=abs(ar(1,i)-initial)
end
min1=1000;
for j=1:length(ar)
if lookup(1,j)
if (min1>dif(1,j)) then
min1=dif(1,j)
pos=j
end
end
end
endfunction
///////////////////////////////////////////////////////////////////
//Function to find out the correct sequence
function [seek_seq,seeked]=sstf_in(ar, initial,p)
len=length(ar);
if len==0 then
return
end
seeked=0; //To track the Seek Count
if p==1 then
    disp("Positions wise sequence:")
end
for i=1:len
[pos,dif,lookup]=mindist(ar,initial,dif,lookup);
lookup(1,pos)=0;
seeked=seeked+dif(1,pos);
initial=ar(1,pos);
seek_seq(1,i)=initial;
    if p==1 then
        disp(pos);
    end
end
if p==1 then
    disp("Sequence to Seek:")
    disp(seek_seq)
    disp("Total seek count:")
    disp(seeked)
end
endfunction
//////////////////////////////////////////////////////////////////////
function[seek_seq,seeked]=sstf(ar,initial_pos,p,g)
  if ~exists("p","local") then
    p = 0
 end
 if ~exists("g","local") then
    g = 0
 end
//ar=input("Enter the seek positions:") // Seek positions.
//initial_pos=input("Enter the initial Head position:") // Initial Head position.
seek_seq=[];
for i=1:length(ar)
lookup(1,i)=1;
dif(1,i)=0;
seek_seq(1,i)=-1;
end
y=[1:length(ar)]
[seek_seq,seeked]=sstf_in(ar,initial_pos,p);
if g==1 then
    subplot(121)
    plot(ar,y,"og")
    plot(ar,y)
    title("FCFS positions")
    subplot(122)
    plot(seek_seq,y,"or")
    plot(seek_seq,y)
    title("SSTF Sequence")  
end
endfunction
clear dif
clear pos
clear lookup
