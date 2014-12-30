### Using Iterators P.10
#
# ���²��
# An iterator is a special type of object that generalizes the notion of a looping variable.
# When passed as an argument to a function that knows what to do with it, the iterator supplies a sequence of values. 
# The iterator also maintains information about its state, in particular its current index.
#
# iterators�]²��
#
# �ͦ�iterator����̰򥻪���k iter()�A �N���N��R�����নiterator����
# The iterators package includes a number of functions for creating iterators.
# the simplest of which is iter, which takes virtually any R object and turns it into an iterator object.
#
# �ާ@iterator���󪺰򥻤�k nextElem()
# The simplest function that operates on iterators is the nextElem function,
# which when given an iterator, returns the next value of the iterator.
# 
# �d��
# library(iterators) 
#
# �V�q
# i1<-iter(1:10)
# nextElem(i1)
# nextElem(i1)
#
# matrices and data.frames, �ϥΰѼƿ�{�n�H�@�C�Τ@���iterator���N�����
# istate<- iter(state.x77,by="row")
# nextElem(istate)
# nextElem(istate)
#
# ���, �ϥ�nextElem�ɡA�p�P���]�@����ơA�Y���G�Ȧ��榸�ɡC
# Iterators can also be created from functions
# ifun<-iter(function(){sample(0:9,4,replace=T)})
# nextElem(ifun)
# nextElem(ifun)
#
# ������ΡA�`�|�Niterators�Pforeach������
# iterators can be paired with foreach to obtain parallel results quite easily
# library(foreach)
# library(doParallel)
# cl<-makeCluster(5)
# registerDoParallel(cl)
# x<-matrix(rnorm(1000000),ncol=1000)
# itx<-iter(x,by='row')
# foreach(i=itx, .combine=c)%dopar% {mean(i)}
# ��h����foreach http://127.0.0.1:30810/library/foreach/html/foreach.html
#
#
### 1.4.1 Some Special Iterators P.11
# 
# iterators�]�����h�إΨӥͦ�iterators for some scenarios �����
# The iterators package includes a number of special functions that generate iterators for some
# common scenarios.
# 
# �d�ҡGirnorm ��ơA�ͦ��@��iterator�A�̭��C�@�ӭȳ��A�q�H���`�A���t
# library(iterators)
#
# generate an iterator object follow normal distribution
# itrn <- irnorm(1,count=10)
# nextElem(itrn)
# nextElem(itrn) 
#
# generate an iterator object follow uniform   
# itru<-irunif(1,count=10)
# nextElem(itru)
# nextElem(itru)
#
# The icount function returns an iterator that counts starting from one
# it<-icount(3)
# nextElem(it)
# nextElem(it)
# nextElem(it)
#
# �Ѧp����������٦�irunif,irbinom,irpois�A���ͪ�iterators ���O�A�quniform, binomial, Poisson���t
#
### 1.4.2 Writing Iterators P.12
#
# ���ɧڭ̷|�ݭn�ϥΨ�@��iterators�]�������Ѫ�iterator�A���ɫK�ݭn�ۦ�s�giterator
# iterator�� s3������A �åB�� iter �P nextElem ��k�C
# Basically, an iterator is an S3 object whose base class is "iter", and has iter and nextElem methods.

# �ޥ�RevoForeachIterators_Users_Guide.pdf