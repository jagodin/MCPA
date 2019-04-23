% MCPA.m: 
%
%% ELEC4700, Monte Carlo PA-3
% Author: Jacob Godin
% Date: 2019/04/18
%--------------------------------------------------------------------------

% Part 2

% Electron position and velocity vectors
num_e = 3;
x_vec = zeros(num_e,1);
vx_vec = zeros(num_e,1);

% Time variables
Nrpt = 100;
t = 1;
t_step = t/Nrpt;

q = 1.60218e-19;
m = 9.11e-31;
E = 1e3;

colour = hsv(num_e);

P_scatter = 0.10;

t=0;

subplot(3,1,1);
title('Electron Position');
ylabel('Displacement (m)');
hold on;

subplot(3,1,2); 
title('Electron Velocity');
ylabel('Velocity (m/s)');
hold on;

for i=1:Nrpt
    
    % Set v = 0 if electron scatters
    for n=1:length(x_vec)
        if P_scatter > rand()
            vx_vec(n) = 0;
        end
    end

    % Save previous positions
    x_vec_prev = x_vec;
    
    % Save previous velocity
    vx_vec_prev = x_vec;
    
    % Calculate new position
    x_vec = x_vec + vx_vec*t_step;
    
    vx_vec = vx_vec + (q*E/m)*delta_t;
    
    drift_v = mean(vx_vec);
    
    subplot(2,1,1);
    ylabel('Particle Trajectory');
    title('Particle Trajectory Over Time')
    xlim([0 1])
    pause(0.1)
    
    for j=1:num_e
        plot([t,t+t_step],[x_vec_prev(j);x_vec(j)],'color',colour(j,:))
        hold on
    end
    
    subplot(2,1,2);
    title(['Electron Velocity, Drift Velocity = ',num2str(drift_v),' m/s'])
    ylabel('Velocity (m/s)');
    xlabel('Time (s)')
    xlim([0 1])
    pause(0.1)
    
    for j=1:num_e
        plot([t,t+t_step],[vx_vec_prev(j);vx_vec(j)],'color',colour(j,:))
        hold on
    end
    
    t=t+t_step;
end

