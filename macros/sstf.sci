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
