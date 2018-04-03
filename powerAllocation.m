function Rate2_low = powerAllocation(k_cluster, users_dist,k_index, powers_all,k_means_center,height_all)
Rate2_low = [];    
for k_circle = 1 : k_cluster
            users_final_self = users_dist(k_index==k_circle,:);
            %users_final_other = users_dist(k_index~=k_circle,:);
             for k_in_cluster = 1:size(users_final_self,1)
              R =  norm(users_final_self(k_in_cluster,:) - k_means_center(k_circle,1:2)); 
              pl_self = Main_Kmeans_SINR(R,height_all(k_circle));
              interf = 0;
          %    pl_else_collect = [];
                for k_else = 1:k_cluster %%%%%Calculate the interference from other centroid
                    if k_else ~= k_circle
                       R_other =  norm(users_final_self(k_in_cluster,:) - k_means_center(k_else,1:2));
                       pl = Main_Kmeans_SINR(R_other,height_all(k_else));
                       interf = interf + 10^((powers_all(k_else) - pl)/10); %%%interference
               %        pl_else_collect = [pl_else_collect pl];
                    end
                end
              signal = powers_all(k_circle) - pl_self;   %%signal
              inter_dB = 10*log10(interf+10^(-8)); %interference and noise are transformed to dB
            %  users_data = [users_data;k_circle pl_self pl_else_collect];
              Rate2_low = [Rate2_low (signal-inter_dB)];             
             end           
end

