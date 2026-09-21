function eta = give_effi(pump_effi, eta_values, flowRate, head)

    Q_all   = [];
    H_all   = [];
    ETA_all = [];

    for i = 1:length(pump_effi)
        P = pump_effi{i};
        Q_all = [Q_all; P(:,1)];
        H_all = [H_all; P(:,2)];
        ETA_all = [ETA_all;
                   eta_values(i)*ones(size(P,1),1)];
    end
    [~ , ix] = unique(round([Q_all , H_all] , 3), 'rows', 'stable'); 
    Q_clean = Q_all(ix);
    H_clean = H_all(ix);
    ETA_clean = ETA_all(ix);

    F = scatteredInterpolant( ...
            Q_clean, ...
            H_clean, ...
            ETA_clean, ...
            'linear' , "none");
    eta = F(flowRate, head);
    Qg = linspace(min(Q_all),max(Q_all),200);
    Hg = linspace(min(H_all),max(H_all),200);

    [Qm,Hm] = meshgrid(Qg,Hg);

    Etam = F(Qm,Hm);

    figure
    contourf(Qm,Hm,Etam,20 , "lineColor","none")
    colorbar
    hold on
    plot(flowRate , head , "k*")
end