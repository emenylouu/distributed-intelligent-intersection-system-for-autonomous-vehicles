function [p, v, u] = dynamics(coe, pos, speed, flag)
t = get_param('Intersection', 'SimulationTime');
if flag == 0
    % flag: 1 (cruise); 0 (control)
    v = 1 / 2 * coe(1) * t ^ 2 + coe(2) * t + coe(3);
    p = 1 / 6 * coe(1) * t ^ 3 + 1 / 2 * coe(2) * t^2 + coe(3) * t + coe(4);
    
    u = coe(1) * t + coe(2);
else
    p = pos + speed * 0.1;
    v = speed;
    u = 0;
end