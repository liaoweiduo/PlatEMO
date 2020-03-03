
figure()
hold on
view(2)
axis equal

points = zeros(100,2);
for i = 1:10000
    points(i,1) = (mod(i-1,100)+1)/100;
    points(i,2) = ceil((i)/100)/100;
end
scatter(points(:,1),points(:,2),'b.')
xlim([0,1])
ylim([0,1])

rv = [1/2,1/2];
pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
normalPoints = points ./ pointsLength;
pdash = normalPoints + 1 .* rv;
pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
figure()
hold on
view(2)
axis equal
scatter(pdash(:,1),pdash(:,2),'b.')
xlim([0,1])
ylim([0,1])

pdash_domi = pdash(pdash(:,1)>0.2 & pdash(:,2)>0.2,:);
figure()
hold on
view(2)
axis equal
scatter(pdash_domi(:,1),pdash_domi(:,2),'b.')
xlim([0,1])
ylim([0,1])

p_domi = points(pdash(:,1)>0.2 & pdash(:,2)>0.2,:);
figure()
hold on
view(2)
axis equal
scatter(p_domi(:,1),p_domi(:,2),'b.')
xlim([0,1])
ylim([0,1])
% points = [0.2,0.7];
% scatter(points(:,1),points(:,2),2000,'b.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 0.1 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 0.5 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 0.8 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 1 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 1.25 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 2 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 10 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% 
% points = [0.7,0.2];
% 
% scatter(points(:,1),points(:,2),2000,'b.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 0.1 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 0.5 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 0.8 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 1 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 1.25 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 2 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')
% 
% rv = [1/2,1/2];
% pointsLength = sqrt(points(:,1) .^ 2 + points(:,2) .^ 2);
% normalPoints = points ./ pointsLength;
% pdash = normalPoints + 10 .* rv;
% pdash = pdash ./ sqrt(pdash(:,1) .^ 2 + pdash(:,2) .^ 2) .* pointsLength;
% scatter(pdash(:,1),pdash(:,2),2000,'r.')



