function [pos] = findLRU(time, n)
    pos = 1;
    minimum = time(1);
    
    for i = 1:n
        if time(i) < minimum
            minimum = time(i);
            pos = i;
        end
    end
endfunction

function [faults] = lru(no_frames, no_pages, ref_string, p)
    flag1 = 0;
    flag2 = 0;
    counter = 0;
    faults = 0;
    frames = [];
    time = [];
    
    if ~exists("p","local") then
        p = 0
    end
    
    for i = 1:no_frames
        frames(i) = -1;
    end
    
    for i = 1:no_pages
        flag1 = 0;
        flag2 = 0;
        
        for j = 1:no_frames
            if (frames(j) == ref_string(i))
                counter = counter + 1;
                time(j) = counter;
                flag1 = 1;
                flag2 = 1;
                break;
            end
        end
        
        if flag1 == 0
            for j = 1:no_frames
                if frames(j) == -1
                    counter = counter + 1;
                    faults = faults + 1;
                    frames(j) = ref_string(i);
                    time(j) = counter;
                    flag2 = 1;
                    break;
                end
            end
        end
        
        if flag2 == 0
            pos = findLRU(time, no_frames)
            counter = counter + 1;
            faults = faults + 1;
            frames(pos) = ref_string(i);
            time(pos) = counter;
        end
        
        if p == 1 then
            mprintf("\n");
            for j = 1:no_frames
                mprintf("%d\t", frames(j));
            end
        end
        
    end
    if p == 1 then
        mprintf("\n\nTotal Page Faults = %d \n\n", faults);
    end
    
endfunction
