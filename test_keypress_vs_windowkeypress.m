function test_keypress_vs_windowkeypress

h.hf = figure();
h.edit = uicontrol('Style', 'edit', 'Units', 'Normalized',...
    'Position', [0.2, 0.2, 0.6, 0.6]);

% set callbacks
set(h.hf, 'KeyPressFcn', @wintest);
set(h.edit, 'KeyPressFcn', @edittest);

function wintest(h, e)
    e.Key
    disp('window button press');

function edittest(h, e)
    disp('editbox button press');