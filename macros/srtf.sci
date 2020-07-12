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
