###�i�ܥ�rxExec�@���U���h���ɮ�
# install.package("downloader")
library(downloader)
rxSetComputeContext(RxLocalParallel())
t1<-c("http://packages.revolutionanalytics.com/datasets/AirOnTimeCSV2012/airOT201201.csv","D:/LBH/1.csv")
t2<-c("http://packages.revolutionanalytics.com/datasets/AirOnTimeCSV2012/airOT201202.csv","D:/LBH/2.csv")
rxExec(download,elemArgs=list(t1,t2),elemType="cores")


###�i�ܥ�rxExec��Y�V�q�i����,�íp�⧡��,�H�Ѽƪ��覡�ǿ骫��ܨ�L�֤ߤ��B��
# �üƥͦ�1600��0~1������
set.seed(2123)
t3<-runif(1600) 
# �]�wComputeContext���������B��
rxSetComputeContext(RxLocalParallel())
sampleCalculateMean<-function(vector){
	#set.seed(1234) #������ե�
	temp<-sample(0:1,size=1600,replace=T)
	totalElement<-vector[which(temp==1)]
	mean(totalElement)
}
rxExec(sampleCalculateMean,t3,elemType="cores",timesToRun=2,RNGseed=3213)


###�i��rxExec�H�D�Ѽƪ��覡,�ǿ��Ʀܨ�L�֤ߤ����B��
# �üƥͦ�1600��0~1������
set.seed(2123)
t3<-runif(1600) 
# �]�wComputeContext���������B��
rxSetComputeContext(RxLocalParallel())
sampleCalculateMean<-function(){
	#set.seed(1234) #������ե�
	temp<-sample(0:1,size=1600,replace=T)
	totalElement<-t3[which(temp==1)]
	mean(totalElement)
}
rxExec(sampleCalculateMean,elemType="cores",timesToRun=2,RNGseed=3213,execObjects=c("t3"))
