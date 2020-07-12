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


