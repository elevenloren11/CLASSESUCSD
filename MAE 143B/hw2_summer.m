%% HW#2 
close all, d=12; a0=.02; G=RR_pade(d,2,2)*RR_tf(1,[1/a0 1]); D=1; P=1/0.5;
figure(1), RR_rlocus(G), axis([-.4 .3 -.3 .3]);
figure(2), g.T=200; RR_step(35+10*P*G*D/(1+G*D),g); axis([0 200 32 55]) ;
figure(3); RR_step(35+10*P*D/(1+G*D),g); axis([0 200 40 60]) ;

%%
clear all; close all;

%Check RR_pade(d,16,13)by replacing RR_pade(d,2,2)
d=12; a0=.02; G=RR_pade(d,16,13)*RR_tf(1,[1/a0 1]);
K = 0.488; D=RR_tf(K);
figure(4), RR_rlocus(G)

%attempted decreasing gain to K=0,5 max u(t)= 50.1227, setting time 
% ts= 98.2 secs
%continued decreasing K and found K=0.488 is closet in reaching almost 
% exactly Tmax with a settling time 99.2 secs 
% K=0.486, max_u(t)= 49.9782, ts= 99.4 secs 


%Pre loop factor 
G1 = 1; P=(1 +G1*K)/(G1*K);
figure(5), g.T=200; [t,~,y] = RR_plot_response(35+10*P*G*D/(1+G*D), 0, g);
grid on; hold on; axis([0 g.T 34 55]);

s_idx = find(abs(y - 45) < 0.5); s_idx = s_idx(1); t_idx = t(s_idx);
xline(t_idx, "-", "settling time: $t = " + num2str(t_idx) + "$ s", ...
"FontSize", 14, "Interpreter", "latex");
yline(45, "--", "Color", "b");
figure(6), [~,~,y] = RR_plot_response(35+10*P*D/(1+G*D), 0, g);
grid on; hold on; axis([0 200 40 60])
max(y),
yline(max(y), "-", "Max $u(t)= " + num2str(max(y)) + "$", ...
"FontSize", 14, "Interpreter", "latex");

%% with lead controller 

clear all; close all;

d = 12; a0 = .02; 
G =  RR_pade(d,16,13)* RR_tf(1, [1/a0 1]);

K= 0.558; z= 0.02;  p= 0.25;   
P= 2.66; D=K*RR_tf([1 z], [1 p]); 

figure(1), RR_rlocus(G, D), axis([-.4 .3 -.3 .3]);
figure(2); g.T = 200; 
[t, ~, y] = RR_plot_response(35 + 10*P*G*D/(1 + G*D), 0, g);
grid on; hold on; axis([0 g.T 34 55]);


t = t(:); y = y(:);
%fixing settling time 
[~, max_idx] = max(y); 

peak = find(abs(y(max_idx:end) - 45) >= 0.5, 1, 'last');

if ~isempty(peak) && (max_idx + peak) <= length(t)
    t_idx = t(max_idx + peak);
else
    t_idx = t(max_idx); 
end

xline(t_idx, "--", "Settling time: $t = " + num2str(t_idx, '%.2f') + "$ s", ...
    "FontSize", 14, "Interpreter", "latex");
yline(45, "--", "Color", "b");

figure(3); 
[~, ~, u] = RR_plot_response(35 + 10*P*D/(1 + G*D), 0, g);
grid on; hold on; axis([0 200 30 60]);

yline(max(u), "-", "max $u(t) = " + num2str(max(u), '%.2f') + "$", ...
    "FontSize", 14, "Interpreter", "latex");
