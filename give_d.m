function [selected_D , index] = give_d(pump_D,pump_D_values,flowRate,head)
figure
hold on
plot(flowRate , head , "k*")
for i = 1:length(pump_D)
    [Q_clean, idx] = unique(pump_D{i}(:,1));
    H_clean = pump_D{i}(idx, 2);
    plot(pump_D{i}(idx , 1) , pump_D{i}(idx , 2))
    H_at_Q = interp1(Q_clean ,H_clean , flowRate , "linear" );
    if H_at_Q >= head
        selected_D = pump_D_values(i);
        index = i;
        break;
    end
end
end