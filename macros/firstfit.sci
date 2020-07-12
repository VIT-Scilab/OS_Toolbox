function [ff_allot, ff_allotsize] = firstfit(proc,b, p)
    if ~exists("p","local") then
        p = 0
    end
    size_process = size(proc)(2)
    size_block = size(b)(2)
    ff_allot = zeros(1,size_process);
    ff_flag = zeros(1,size_block);
    for i=1:size_process
        for j=1:size_block
        if proc(i) <= b(j) && ff_flag(j)==0 then 
            ff_allot(i) = j;
            ff_flag(j) = 1; 
            break
            end,         
        end
    end
    ff_allotsize = zeros(1,size_process);
    for i=1:size_process
        if ff_allot(i)~=0 then
            ff_allotsize(i) = b(ff_allot(i));
        else
            ff_allotsize(i) = -1
            ff_allot(i) = -1
        end,
    end
    if p == 1 then
        mprintf("FIRST FIT:\n")
        mprintf("Process no. \tProcess size\tBlock no. \tBlock size\n")
        for i=1:size_process
            if ff_allot(i)== -1 then
                mprintf("%d\t\t%d\t\tNot allocated  \t  -\n",i,proc(i))
            else
                mprintf("%d\t\t%d\t\t%d\t\t  %d\n",i,proc(i),ff_allot(i),ff_allotsize(i))
            end,
        end
    end
endfunction

