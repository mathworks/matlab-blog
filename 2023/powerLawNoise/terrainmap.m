function map = terrainmap(n)
% Create a terrain colormap with shades of blue in the lower half and land
% shades in the upper half.
% Danz 231126
if nargin < 1
    f = get(groot,'CurrentFigure');
    if isempty(f)
        n = size(get(groot,'DefaultFigureColormap'),1);
    else
        n = size(f.Colormap,1);
    end
else
    assert(isscalar(n) && n>=0, 'n must be scalar and nonnegative.')
end

% Divide colormap into water and land sections
nWater = ceil(n/2);
nLand = n-nWater;

% Create water colormap
rc = zeros(nWater,1);
gc = max(0,linspace(-1,1,nWater)).';
bc = min(1,linspace(0,2,nWater)+0.2).';
waterCM = [rc,gc,bc];

% Create land colormap
nGreen = ceil(nLand/2);
nBrown = nLand-nGreen;
pinkBuffer = ceil(nBrown * 7/6);
pinkCM = pink(pinkBuffer);
greenCM = summer(nGreen);
greenBrownCM = [greenCM;flipud(pinkCM(1:nBrown,:))];
landCM = movmean(greenBrownCM,ceil(max(1,nLand)*.1)); % Blended to remove seam

% Create the combined colormap
map = [waterCM; landCM];

end