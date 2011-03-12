#!/bin/sh

# $Id: tests.sh,v 1.51 2006/03/30 02:22:56 gilles Exp $	

#### Shell pragmas

exec 3>&2 # 
#set -x   # debug mode. See what is running
set -e    # exit on first failure

#### functions definitions

echo3() {
	#echo '#####################################################' >&3
	echo "$*" >&3
}

run_test() {
	echo3 "#### $test_count $1"
	$1
	if test x"$?" = x"0"; then
 		echo "$1 passed"
	else
		echo "$1 failed" >&2
	fi
}

run_tests() {
	for t in $*; do
		test_count=`expr 1 + $test_count`
		run_test $t
		sleep 1
	done
}


#### Variable definitions

test_count=0

##### The tests functions

perl_syntax() {
	perl -c ./imapsync
}


no_args() {
	./imapsync
}


first_sync() {
	./imapsync \
	    --host1 localhost --user1 toto@est.belle \
	    --passfile1 /var/tmp/secret1 \
	    --host2 localhost --user2 titi@est.belle \
	    --passfile2 /var/tmp/secret2 \
	    --noauthmd5
}

sendtestmessage() {
    rand=`pwgen 16 1`
    mess='test:'$rand
    cmd="echo $mess""| mail -s ""$mess"" tata"
    echo $cmd
    ssh gilles@loul $cmd
}

loulplume() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		sendtestmessage
		./imapsync \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata
	else
		:
	fi
}

loulloul() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		sendtestmessage
		./imapsync \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--host2 loul --user2 titi \
		--passfile2 /var/tmp/secret.tata
	else
		:
	fi
}



plumeloul() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host1 plume --user1 tata@est.belle \
		--passfile1 /var/tmp/secret.tata \
		--host2 loul  --user2 tata \
		--passfile2 /var/tmp/secret.tata 
	else
		:
	fi
}

lp_folder() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--folder INBOX.yop --folder INBOX.Trash  \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata
	else
		:
	fi
}

lp_buffersize() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--buffersize 8
	else
		:
	fi
}



lp_justfolders() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--folder INBOX.yop --folder INBOX.Trash  \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--justfolders 
	else
		:
	fi
}


pl_folder_qqq() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host1 plume --user1 tata@est.belle \
		--passfile1 /var/tmp/secret.tata \
		--folder INBOX.qqq  \
		--host2 loul  --user2 tata \
		--passfile2 /var/tmp/secret.tata
	else
		:
	fi
}

pl_prefix12() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host1 plume --user1 tata@est.belle \
		--passfile1 /var/tmp/secret.tata \
		--folder INBOX.qqq  \
		--host2 loul  --user2 tata \
		--passfile2 /var/tmp/secret.tata \
		--prefix1 INBOX.\
		--prefix2 INBOX. \
	else
		:
	fi
}



lp_internaldate() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		sendtestmessage
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--folder INBOX  \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--syncinternaldates
	else
		:
	fi
}




pl_folder() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host1 plume --user1 tata@est.belle \
		--passfile1 /var/tmp/secret.tata \
		--folder INBOX.yop \
		--host2 loul  --user2 tata \
		--passfile2 /var/tmp/secret.tata
	else
		:
	fi
}

lp_subscribed() 
{
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--subscribed
	else
		:
	fi
}


lp_subscribe() 
{
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--subscribed --subscribe
	else
		:
	fi
}

lp_justconnect() 
{
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync    \
		--host2 plume \
		--host1 loul  \
		--justconnect
	else
		:
	fi
}

lp_justfoldersizes() 
{
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--justfoldersizes
	else
		:
	fi
}



lp_authmd5() 
{
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--justfoldersizes
	else
		:
	fi
}

lp_noauthmd5() 
{
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--justfoldersizes --noauthmd5
	else
		:
	fi
}


lp_maxage() 
{
	sendtestmessage
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--maxage 1
	else
		:
	fi
}



lp_maxsize() 
{
	sendtestmessage
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--maxsize 10
	else
		:
	fi
}

lp_skipsize() 
{
	sendtestmessage
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--skipsize --folder INBOX.yop.yap
	else
		:
	fi
}

lp_skipheader() 
{
	sendtestmessage
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--skipheader 'X-.*' --folder INBOX.yop.yap
	else
		:
	fi
}



lp_include() 
{
	sendtestmessage
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--include '^INBOX.yop'
	else
		:
	fi
}

lp_regextrans2() 
{
	sendtestmessage
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--regextrans2 's/yop/yopX/' --dry
	else
		:
	fi
}

lp_sep2() 
{
	
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--folder INBOX.yop.yap \
		--sep2 '\\' --dry
	else
		:
	fi
}



bad_login()
{
    ! ./imapsync \
	--host1 localhost --user1 toto@est.belle \
	--passfile1 /var/tmp/secret1 \
	--host2 localhost --user2 notiti@est.belle \
	--passfile2 /var/tmp/secret2
   
}

bad_host()
{
    ! ./imapsync \
	--host1 badhost --user1 toto@est.belle \
	--passfile1 /var/tmp/secret1 \
	--host2 badhost --user2 titi@est.belle \
	--passfile2 /var/tmp/secret2
   
}


foldersizes()
{
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--justfoldersizes
	else
		:
	fi

}


big_transfert()
{
    date1=`date`
    { ./imapsync \
	--host1 louloutte --user1 gilles \
	--passfile1 /var/tmp/secret \
	--host2 plume --user2 tete@est.belle \
	--passfile2 /var/tmp/secret.tete \
	--subscribed --foldersizes --noauthmd5 \
        --fast --folder INBOX.Backup \
	--useheader Message-ID --useheader Received || \
    true
    }
    date2=`date`
    echo3 "[$date1] [$date2]"
}

big_transfert_sizes_only()
{
    date1=`date`
    { ./imapsync \
	--host1 louloutte --user1 gilles \
	--passfile1 /var/tmp/secret \
	--host2 plume --user2 tete@est.belle \
	--passfile2 /var/tmp/secret.tete \
	--subscribed  --noauthmd5 \
	--justfoldersizes  || \
    true
    }
    date2=`date`
    echo3 "[$date1] [$date2]"
}



dprof()
{
    date1=`date`
    { perl -d:DProf ./imapsync \
	--host1 louloutte --user1 gilles \
	--passfile1 /var/tmp/secret \
	--host2 plume --user2 tete@est.belle \
	--passfile2 /var/tmp/secret.tete \
	--subscribed --foldersizes --noauthmd5 \
        --folder INBOX.Trash || \
    true
    }
    date2=`date`
    echo3 "[$date1] [$date2]"
    dprofpp tmon.out
}

essnet_justconnect()
{
./imapsync \
	--host1 mail2.softwareuno.com \
	--user1 gilles@mail2.softwareuno.com  \
	--passfile1 /var/tmp/secret.prw \
	--host2 mail.softwareuno.com \
	--user2 gilles@softwareuno.com \
	--passfile2 /var/tmp/secret.prw \
	--dry --noauthmd5 --sep1 / --foldersizes --justconnect
}

essnet_mail2_mail()
{
./imapsync \
	--host1 mail2.softwareuno.com \
	--user1 gilles@mail2.softwareuno.com  \
	--passfile1 /var/tmp/secret.prw \
	--host2 mail.softwareuno.com \
	--user2 gilles@softwareuno.com \
	--passfile2 /var/tmp/secret.prw \
	--noauthmd5 --sep1 / --foldersizes \
        --prefix2 "INBOX/" --regextrans2 's�INBOX/INBOX�INBOX�'
}

essnet_mail2_mail_t123()
{

for user1 in test1 test2 test3; do
	./imapsync \
	--host1 mail2.softwareuno.com \
	--user1 ${user1}@mail2.softwareuno.com  \
	--passfile1 /var/tmp/secret.prw \
	--host2 mail.softwareuno.com \
	--user2 gilles@softwareuno.com \
	--passfile2 /var/tmp/secret.prw \
	--noauthmd5 --sep1 / --foldersizes \
	--prefix2 "INBOX/" --regextrans2 's�INBOX/INBOX�INBOX�' \
        --debug \
	|| true
done
}


essnet_plume2()
{
./imapsync \
	--host1 mail2.softwareuno.com \
	--user1 gilles@mail2.softwareuno.com  \
	--passfile1 /var/tmp/secret.prw \
	--host2 plume --user2 tata@est.belle \
	--passfile2 /var/tmp/secret.tata \
        --noauthmd5 --sep1 / --foldersizes \
        --prefix2 INBOX. --regextrans2 's�INBOX.INBOX�INBOX�'
}

dynamicquest_1()
{

perl -I bugs/lib ./imapsync \
	--host1 69.38.48.81 \
	--user1 testuser1@dq.com \
	--passfile1 /var/tmp/secret.dynamicquest \
	--host2 69.38.48.81 \
	--user2 testuser2@dq.com \
	--passfile2 /var/tmp/secret.dynamicquest \
	--noauthmd5 --sep1 "/" --sep2 "/" \
	--justconnect --dry 
}

dynamicquest_2()
{

perl -I bugs/lib ./imapsync \
	--host1 mail.dynamicquest.com \
	--user1 gomez \
	--passfile1 /var/tmp/secret.dynamicquestgomez \
	--host2 69.38.48.81 \
	--user2 testuser2@dq.com \
	--passfile2 /var/tmp/secret.dynamicquest \
	--noauthmd5 \
	--justconnect --dry 
}

dynamicquest_3()
{

perl -I bugs/lib ./imapsync \
	--host1 loul \
	--user1 tata \
	--passfile1 /var/tmp/secret.tata \
	--host2 69.38.48.81 \
	--user2 testuser2@dq.com \
	--passfile2 /var/tmp/secret.dynamicquest \
	--noauthmd5 --sep2 "/" --debug --debugimap
	
}




useheader() 
{
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--folder INBOX.yop.yap \
		--useheader 'Message-ID' \
		--dry --debug
		
		echo 'rm /home/vmail/tata/.yop.yap/cur/*'
	else
		:
	fi
}


regexmess() 
{
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--folder INBOX.yop.yap \
		--regexmess 's/\157/O/g' \
		--regexmess 's/p/Z/g' \
		--dry --debug
		
		echo 'rm /home/vmail/tata/.yop.yap/cur/*'
	else
		:
	fi
}


flags() 
{
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--folder INBOX.yop.yap \
		--dry --debug
		
		echo 'rm /home/vmail/tata/.yop.yap/cur/*'
	else
		:
	fi
}


lp_ssl() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--ssl1 --ssl2
	else
		:
	fi
}

lp_authmech_PLAIN() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--justfoldersizes --nofoldersizes \
		--authmech1 PLAIN --authmech2 PLAIN
	else
		:
	fi
}

lp_authuser() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--justfoldersizes --nofoldersizes \
		--authuser2 tata@est.belle
	else
		:
	fi
}




lp_authmech_LOGIN() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--justfoldersizes --nofoldersizes \
		--authmech1 LOGIN --authmech2 LOGIN 
	else
		:
	fi
}

lp_authmech_CRAMMD5() {
	if test X`hostname` = X"plume"; then
		echo3 Here is plume
		./imapsync \
		--host2 plume --user2 tata@est.belle \
		--passfile2 /var/tmp/secret.tata \
		--host1 loul  --user1 tata \
		--passfile1 /var/tmp/secret.tata \
		--justfoldersizes --nofoldersizes \
		--authmech1 CRAM-MD5 --authmech2 CRAM-MD5 
	else
		:
	fi
}



# mandatory tests

run_tests perl_syntax 

# All tests
# lp : louloutte -> plume
# pl : plume -> louloutte

test $# -eq 0 && run_tests \
	no_args \
	first_sync \
	loulplume \
	plumeloul \
	lp_folder \
	lp_buffersize \
	pl_folder \
        pl_folder_qqq \
	pl_prefix12 \
	lp_internaldate \
	lp_subscribed \
	lp_subscribe \
	lp_justconnect \
	lp_justfoldersizes \
	lp_authmd5 \
	lp_maxage \
	lp_maxsize \
	lp_include \
	bad_login \
	bad_host \
	lp_noauthmd5 \
        lp_skipsize \
        lp_skipheader \
	lp_regextrans2 \
	foldersizes \
	regexmess \
	useheader \
        lp_ssl \
	lp_authmech_LOGIN \
	lp_authmech_CRAMMD5 \
	lp_authmech_PLAIN \
	lp_authuser




# selective tests

test $# -gt 0 && run_tests $*

# If there, all is good

echo3 ALL $test_count TESTS SUCCESSFUL

