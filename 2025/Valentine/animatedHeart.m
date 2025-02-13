% Originally from https://www.reddit.com/r/matlab/comments/1eq66kc/made_a_heart_on_matlab/
figure
a = 0:5:1700;
x = -2:0.005:2;
y = zeros(size(x));
h = plot(x, y, 'r');
axis([-2 2 -2 3]);
for i = a
    y = nthroot(x,3).^2 + 1.1.*sin(i*x).*sqrt(4-x.*x);
    set(h, 'YData', y);
    pause(0.1);
end