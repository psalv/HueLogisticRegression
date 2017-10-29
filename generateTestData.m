
n = ones(24, 1);
x1 = [];
x2 = [];
for i = 1:7,
	x1 = [x1; n * i];
	x2 = [x2; [0:23]'];
end

x = [x1 x2];
x = [x; x; x; x; x; x; x; x; x; x];
x = [x; x; x];
random = rand(size(x), 1) * 2;
r = random >= 0.5;
data = [x r];

save testData.txt data -ascii;
