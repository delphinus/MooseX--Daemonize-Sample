MooseX::Daemonize テストスクリプト
==================================
[MooseX::Daemonize][moosex-daemonize] を使って作ったテストスクリプトです。

使い方
------

### 一度だけ実行する

	$ ./once
	1

コンソールにカウンターを表示してすぐに終了します。

### 定期的に実行する

	$ ./daemon -i 10 start

10 秒ごとにカウンターを記録します。オプション `-i` に指定するのは実行間隔です。（デフォルト : 10 秒）

ログファイルには以下のような記録が残ります。

> [2012-01-08 21:20:26] ./daemon : START!  
> [2012-01-08 21:20:26] ./daemon : 1  
> [2012-01-08 21:20:36] ./daemon : 2  
> [2012-01-08 21:20:46] ./daemon : 3  
> [2012-01-08 21:20:50] ./daemon : END!

[moosex-daemonize]: http://search.cpan.org/~stevan/MooseX-Daemonize-0.13/lib/MooseX/Daemonize.pm "MooseX::Daemonize - search.cpan.org"
