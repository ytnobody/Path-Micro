requires 'perl', '5.008001';
requires 'File::Spec';
requires 'File::Basename';
requires 'Guard';


on 'test' => sub {
    requires 'Test::More', '0.98';
};

