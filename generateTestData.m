
n = ones(24, 1);
x1 = [];
x2 = [];
for i = 1:7,
	x1 = [x1; n * i];
	x2 = [x2; [0:23]'];
end

noon = find(x2 == 12);
one = find(x2 == 1);
two = find(x2 == 2);

x = [x1 x2];
y = zeros(size(x1), 1);
y(noon) = 1;
y(one) = 1;
y(two) = 1;

x = [x; x; x; x; x; x; x; x; x; x];
y = [y; y; y; y; y; y; y; y; y; y];

x = [x; x; x; x; x; x; x; x; x];
y = [y; y; y; y; y; y; y; y; y];


%random = zeros(size(x), 1);
%r = random >= 0.5;
%r(noon) = 1;
%r(one) = 1;
%r(two) = 1;

r = y;

[x, r] = randomizeData(x, r);

data = [x r];

save testData.txt data -ascii;
