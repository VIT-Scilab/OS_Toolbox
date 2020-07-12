// Function to sort the processes in the order of arrival time
function [] = sort_processes(pro,at,bt,pri,n)
    for i=2:n
        j=i-1;
        key1 = pro(i);
        key2 = at(i);
        key3 = bt(i);
        key4 = pri(i);
        while j>=1 && key2 < at(j)
            at(j+1) = at(j);
            bt(j+1) = bt(j);
            pro(j+1) = pro(j);
            pri(j+1) = pri(j);
            j = j-1;
        end
           pro(j+1) = key1;
           at(j+1) = key2;
           bt(j+1) = key3;
           pri(j+1) = key4; 
    end
endfunction

// Function to find the the least prioritised process
function [min_index] = find_least_priority(pri,at,ct,n)
    min_value = pri(1);
    min_index = 1;
    for i=1:n 
        if at(i) <= ct then
            if pri(i) < min_value then
                min_value = pri(i);
                min_index = i;
            end
        end
    end
endfunction

function [tat,wt] =  priority(n,pri,at,bt,p)
    if ~exists("p","local") then
        p = 0
    end
    for i=1:n
        pro(i) = i;
    end
    sort_processes(pro,at,bt,pri,n)
    for i=1:n
        bt1(i) = bt(i);
        pri1(i) = pri(i);
    end
    mprintf("\nGantt Chart\n")
    //Calculate Completion Time
    loop_count = n;
    i = find_least_priority(pri,at,at(1),n)
    mprintf("p%d ",pro(i))
    c = at(i) + 1;
    ct(i) = c;
    bt(i) = bt(i) - 1;
    if bt(i) = = 0 then
        pri(i) = 9999;
        loop_count = loop_count - 1;
    end
    while loop_count > 0
        prev_i = i;
        i = find_least_priority(pri,at,c,n)
        if prev_i ~= i then
            mprintf("p%d ",pro(i))
        end
        c = c+1;
        ct(i) = c;
        bt(i) = bt(i) - 1;
        if bt(i) == 0 then
            pri(i) = 9999;
            loop_count = loop_count - 1;
        end
    end
    // Calculate Waiting Time and Turnaround Time
    sum_tat = 0;
    sum_wt = 0;
    for i=1:n
        tat(i) = ct(i) - at(i);
        wt(i) = tat(i) - bt1(i);
        sum_tat = sum_tat + tat(i);
        sum_wt = sum_wt + wt(i);
    end
    if p = = 1 then
        mprintf("\n\nProcess     Priority      Arrival Time      Burst Time      Completion Time      Turnaround Time     Waiting Time\n")
    for i=1:n
        mprintf("P%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t\t%d\t\t\t%d\n",pro(i),pri1(i),at(i),bt1(i),ct(i),tat(i),wt(i))
    end
    mprintf("\nAvg Turn Around Time: %.2f\nAvg Waiting Time: %.2f\n",sum_tat/n,sum_wt/n)    
else 
    mprintf("\nEnable Printing Output\n")
    end
endfunction
