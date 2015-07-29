%h=zeros(1,100000);
for i = 125:125:50000
data = load(['gapfiles/gaplist' num2str(i)]);
X=data(:,2);
sump=sum(data(:,4));
P=data(:,4)/sump;

%for l = 1:100000
	   f = X(find(rand<cumsum(P),1,'first'));
disp ([num2str(f), " ", num2str(i)])
end
%h(1,l)=f;
%end
%hist(h, 50);

