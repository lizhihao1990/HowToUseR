# The foreach package is a set of tools that allow you to run virtually anything that can be
# expressed as a for-loop as a set of parallel tasks

library(foreach)

# �ϥ� foreach �|�^�Ǥ@��list�A���]�t�C�@���p�⪺���G�C
# �ϥ�for�j��A�O�^�ǳ̫�@���p�⪺���G�Ψ̷ӨϥΪ̪��w�q


# %do%
foreach(i= 1:10)%do% sample(c("H","T"),10000,replace=T)

# %�ϥ�%dopar%�A �ݭn parallel backend registered ������C
foreach(i= 1:10)%dopar% sample(c("H","T"),10000,replace=T)

## Parallel Backends

# �b�ϥ�foreach�ɡA�ݭn���Uparallel backend
# doParallel: �ϥ�parallel�]�b�h�֤W������B��(�h���x�䴩)
# doMC      : �ϥ�multicore�]�b�h�֤W������B��(�Ȥ��Linux)

# To use a parallel backend, you must first register it. Once a parallel backend is registered,
# calls to %dopar% run in parallel using the mechanisms provided by the parallel backend.

## Using the doParallel parallel backend P.7
# parallel�]��X�Fsnow�Pmulticore�], doParallel similarly combines elements of both doSNOW and doMC.
# �ڭ̥i�H�b�O���W�ϥ�doParallel�A�N���ϥ�doSNOW�@�ˡC
# �Φp�PdoMC�@�ˡA�ϥΦh�ֹB��C

# �d�ҡA�@�ϥ�parallel backend, �Y�i�ϥ�foreach�h����ơC
library(doParallel)
# �]�w�|�ֹB��
cl<-makeCluster(5)
registerDoParallel(cl)
# �]�@�U��glm
x<-iris[which(iris[,5]!="setosa"),c(1,5)]
trials<-10000
ptime<-system.time({
	r<-foreach(icount(trials), .combine=cbind)%dopar%{
		ind<-sample(100,100,replace=T)
		result1<-glm(x[ind,2]~x[ind,1],family=binomial(logit))
		coefficients(result1)	
	}
	
})[3]
ptime

## Getting information about the parallel backend P.8

# ���o�ثe���h��worker�ѥ���B��ϥΡA�i�ϥΦ���ƽT�{�ثe�쩳���S������B��
getDoParWorkers()

# �d�ߩҨϥΪ�doPar�覡
getDoParName()

# �d�ߪ���
getDoParVersion()


## 1.3 Nesting Calls to foreach P.8

# An important feature of foreach is nesting operator %:%. Like the %do% and %dopar% operators,
# it is a binary operator, but it operates on two foreach objects.
# It also returns a foreach object

# �H�X�S�dù�k����(�ϥ�sim���),sim��ƻݭn��ӰѼ�. �N�Ҧ����Ȧs�bavec�Pbvec��

# �ǲΤ�k  P.9
sim<-function(a,b){
	10*a+b
}
avec<-1:2
bvec<-1:4

x<-matrix(0,length(avec),length(bvec))
for(j in 1:length(bvec)){
	for(i in 1:length(avec)){
		x[i,j]<-sim(avec[i],bvec[j])
	}	
}

# foreach ����ƺ�k P.9

x<- foreach(b=bvec, .combine='cbind')%:%{
		foreach(a=avec, .combine='c')%do%{
			sim(a,b)	
		}
	}
x	

# P.9
# ��_���j�饭��ơA��ĳ�O��~�h�j�鰵����ƹB��A�o�b�j�q���W��tasks�Τj��tasks�W�|��o���Ĳv�A
# �ӭY�~�h�j�魡�N���Ƥ��h�B�ӥ��Ȥ]�D�`���j�A�b�~�h�j�饭��ơA���|�Q���\�ϥΨ�Ҧ����֤�
# �ӥB�]�|�ɭPŪ�����Ū����D�A���ɥi�H��ܥ���Ƥ��h�j��A���p���@�ӥi��N�|��o���L�Ĳv�A
# �]���������Ʀa���ݤ��h�j��Ҧ������G���^�Ǧܥ~�h�j��A�B�p�Gtasks�P���N�����Ʀh�ܪ��ܡA
# �|�ɭP�������D which loop to parallelize

# the %:% operator does: it turns multiple foreach loops into a single loop.
# That is why there is only one %do% operator in the example above.

x<- foreach(b=bvec, .combine='cbind')%:%{
		foreach(a=avec, .combine='c')%dopar%{
			sim(a,b)	
		}
	}
x	

# the %:% operator makes it easy to specify the stream of tasks to be executed, 
# and the .combine argument to foreach allows us to specify how the results should be processed.

# For more on nested foreach calls, see the vignette ��Nesting foreach Loops�� in the foreach package
####################################################################################################
#
# �Ѧ� RevoForeachIterators_Users_Guide.pdf
# http://www.boyunjian.com/do/article/snapshot.do?uid=3289022633462872166
# http://xccds1977.blogspot.tw/2012/09/parallelforeach.html
#
####################################################################################################