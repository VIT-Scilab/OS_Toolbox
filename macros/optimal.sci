function [faults]= optimal(no_frames, no_pages, ref_string, p)
    flag1 = 0;
    flag2 = 0;
    flag3 = 0;
    counter = 0;
    faults = 0;
    frames = [];
    temp = [];
    
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
                if(frames(j) == ref_string(i))  
                    flag1 = 1;
                    flag2 = 1;
                    break;
                end
            end
        
        if(flag1 == 0)
            for j = 1:no_frames
                if frames(j) == -1 
                    faults = faults + 1;   
                    frames(j)= ref_string(i);
                    flag2 = 1;
                    break;
                end
            end
        end
        
        if(flag2 == 0)
            flag3 = 0;
            for j = 1:no_frames
                temp(j) = -1;
                for k = i+1:no_pages
                    if frames(j) == ref_string(k)
                        temp(j) = k
                        break;
                    end   
                end  
            end
    
            for j = 1:no_frames
                if(temp(j) == -1)
                    pos = j;
                    flag3 = 1;
                    break;
                end
            end   
            if(flag3 == 0)
                maximum = temp(1);
                pos = 1;
                for j = 1:no_frames
                    if temp(j) > maximum
                        maximum = temp(j);
                        pos = j;
                    end
                end
            end
            frames(pos) = ref_string(i)
            faults = faults + 1; 
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
