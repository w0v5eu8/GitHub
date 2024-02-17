% clear ans cbg1 cc ccc ccm code csc i index j j_index temp_cp temp_d temp_hp temp_lp temp_op temp_v raw_stock_fc raw_stock_fh

for i = 1:30
    load('RawData_20131105.mat');
    raw_stock_cp_ed(:,1:1000) = raw_stock_cp(:,102-i:1101-i);
    raw_stock_op_ed(:,1:1000) = raw_stock_op(:,102-i:1101-i);
    raw_stock_hp_ed(:,1:1000) = raw_stock_hp(:,102-i:1101-i);
    raw_stock_lp_ed(:,1:1000) = raw_stock_lp(:,102-i:1101-i);
    raw_stock_v_ed(:,1:1000) = raw_stock_v(:,102-i:1101-i);
    raw_stock_d_ed(:,1:1000) = raw_stock_d(:,102-i:1101-i);

    save(['raw_stock_p_',num2str(raw_stock_d(1,1101-i))], ...
        'raw_stock_cp_ed', 'raw_stock_op_ed', ...
        'raw_stock_hp_ed', 'raw_stock_lp_ed', ...
        'raw_stock_v_ed', 'raw_stock_d_ed');
    clear

end