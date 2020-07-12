function [wf_allot,wf_allotsize] = worstfit(proc,b, p)
    if ~exists("p","local") then
        p = 0
    end
    size_process = size(proc)(2)
    size_block = size(b)(2)
    wf_allot = zeros(1,size_process);
    wf_flag = zeros(1,size_block);
    for i=1:size_process
        k = -1;            
        for j=1:size_block
            if proc(i)<=b(j) && wf_flag(j) == 0 then 
                if k==-1 then
                    k = j; 
                elseif(b(k)<b(j)) 
                    k = j; 
                end,
            end,         
        end
        if(k==-1)
            wf_allot(i)= 0;
        else
            wf_allot(i) = k;
            wf_flag(k) = 1; 
        end,
    end
    wf_allotsize = zeros(1,size_process);
    for i=1:size_process
        if wf_allot(i)~=0 then
            wf_allotsize(i) = b(wf_allot(i));
        else
            wf_allotsize(i) = -1
            wf_allot(i) = -1
        end,
    end
    if p == 1 then
        mprintf("\nWORST FIT:\n")
        mprintf("Process no. \tProcess size\tBlock no. \tBlock size\n")
        for i=1:size_process
         if wf_allot(i)== -1 then
                mprintf("%d\t\t%d\t\tNot allocated  \t  -\n",i,proc(i))
            else
                mprintf("%d\t\t%d\t\t%d\t\t  %d\n",i,proc(i),wf_allot(i),wf_allotsize(i))
            end,
        end
    end
endfunction


