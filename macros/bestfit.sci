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



