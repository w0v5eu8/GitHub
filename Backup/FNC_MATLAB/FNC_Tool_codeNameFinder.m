function output = FNC_Tool_codeNameFinder(Type,key)
% FNC_Tool_codeNameFinder('KRX','�Ｚ����')

%% ������ �ε�
cmd=sprintf('load(''../../DATA/FNC/%s.mat''); DATA=%s;', Type, Type);
eval(cmd);

%%
for i=1:length(DATA)
    if strcmp(DATA(i).codeName, key)
        output = i;
        fprintf('Tyep: %s, codeName: %s, Index: %d\n', Type, key, i);
    end
end