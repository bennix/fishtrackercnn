function [net, info] = cnn_text(varargin)
% CNN_CIFAR   Demonstrates MatConvNet on CIFAR-10
%    The demo includes two standard model: LeNet and Network in
%    Network (NIN). Use the 'modelType' option to choose one.

run(fullfile(fileparts(mfilename('fullpath')), ...
  '..', 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

switch opts.modelType
  case 'lenet'
    opts.train.learningRate = 0.001;
    %opts.train.weightDecay = 0.0001 ;
  otherwise
    error('Unknown model type %s', opts.modelType) ;
end
opts.expDir = fullfile('data', sprintf('char_%s', opts.modelType)) ;


opts.train.numEpochs = 12 ;


opts.dataDir = fullfile('data','char') ;
opts.imdbPath = fullfile(opts.expDir, 'imdb.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.train.batchSize = 100 ;
opts.train.continue = false ;
opts.train.gpus = 1 ;
opts.train.expDir = opts.expDir ;
opts.plotDiagnostics =1;
opts = vl_argparse(opts, varargin) ;

% --------------------------------------------------------------------
%                                               Prepare data and model
% --------------------------------------------------------------------

switch opts.modelType
  case 'lenet', net = initializeCharacterCNN(opts);
  %case 'nin',   net = cnn_cifar_init_nin(opts) ;
end

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getCifarImdb(opts) ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

% --------------------------------------------------------------------
%                                                                Train
% --------------------------------------------------------------------

[net, info] = cnn_train(net, imdb, @getBatchWithJitter, ...
    opts.train, ...
    'val', find(imdb.images.set == 3)) ;
imdb = load('data/charsdb.mat') ;
imageMean = mean(imdb.images.data(:)) ;
net.imageMean = imageMean ;
net.layers(end) = [] ;
save('data/charscnn.mat', '-struct', 'net') ;

% --------------------------------------------------------------------
function [im, labels] = getBatch(imdb, batch)
% --------------------------------------------------------------------
im = imdb.images.data(:,:,batch) ;
im = 256 * reshape(im, 32, 32, 1, []) ;
labels = imdb.images.label(1,batch) ;
%if rand > 0.5, im=fliplr(im) ; end

% --------------------------------------------------------------------
function imdb = getCifarImdb(opts)
% --------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
imdb = load('data/charsdb.mat') ;
imageMean = mean(imdb.images.data(:)) ;
imdb.images.data = imdb.images.data - imageMean ;
%clNames = load(fullfile(unpackPath, 'batches.meta.mat'));

function [im, labels] = getBatchWithJitter(imdb, batch)
% --------------------------------------------------------------------
im = imdb.images.data(:,:,batch) ;
labels = imdb.images.label(1,batch) ;

n = numel(batch) ;
train = find(imdb.images.set == 1) ;

sel = randperm(numel(train), n) ;
im1 = imdb.images.data(:,:,sel) ;

sel = randperm(numel(train), n) ;
im2 = imdb.images.data(:,:,sel) ;

ctx = [im1 im2] ;
ctx(:,17:48,:) = min(ctx(:,17:48,:), im) ;

dx = randi(11) - 6 ;
im = ctx(:,(17:48)+dx,:) ;
sx = (17:48) + dx ;

dy = randi(5) - 2 ;
sy = max(1, min(32, (1:32) + dy)) ;

im = ctx(sy,sx,:) ;

% Visualize the batch:
% figure(100) ; clf ;
% vl_imarraysc(im) ;

im = 256 * reshape(im, 32, 32, 1, []) ;
