function [ay_val, delta_val, dpsi_val] = runQuerdynamik(simTime, simStep, deltaH, rSoll, v, CvStern, ChStern, deltaControl, lv, lh, is, m, theta, g)

    % Init Values
    mDivTheta = m / theta;
    pathelse =0;
    pathif=0;

    % Setup Simulation
    handle = load_system('Querdynamik');
    params = get_param('Querdynamik','modelworkspace');
    params.assignin('deltaControl', deltaControl);
    params.assignin('deltaH', deltaH);
    params.assignin('rSoll', rSoll);
    params.assignin('v', v);
    params.assignin('lv',lv);
    params.assignin('lh',lh);
    params.assignin('CvStern',CvStern);
    params.assignin('ChStern',ChStern);
    params.assignin('is',is);
    params.assignin('mDivTheta',mDivTheta);
    params.assignin('g',g);
    params.assignin('pathif',pathif);
    params.assignin('pathelse',pathelse);

    % Simulate
    simOut = sim('Querdynamik','Solver','ode4','FixedStep',num2str(simStep),'StopTime',num2str(simTime),'debug', 'off');

    ay = simOut.get('ay');
    delta = simOut.get('delta');
    dPSI = simOut.get('dPSI');

    k = 0;
    ay_k = ay(end,1);
    while(ay_k < 2 && k < size(ay(end,:),2))
        k = k + 1;
        ay_k = ay(end,k);
    end
    
    ay_val = ay(end,:);
    delta_val = delta(end,:);
    dpsi_val = dPSI(end,:);
    close_system('Querdynamik',0);
    
end