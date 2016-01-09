#include < stdio.h>
#include < iostream>

#include < opencv2\opencv.hpp>
#include < opencv2/core/core.hpp>
#include < opencv2/highgui/highgui.hpp>
#include < opencv2/video/background_segm.hpp>
#include < opencv2\gpu\gpu.hpp>

#ifdef _DEBUG        
#pragma comment(lib, "opencv_core247d.lib")
#pragma comment(lib, "opencv_imgproc247d.lib")   //MAT processing
#pragma comment(lib, "opencv_objdetect247d.lib") //HOGDescriptor
#pragma comment(lib, "opencv_gpu247d.lib")
//#pragma comment(lib, "opencv_features2d247d.lib")
#pragma comment(lib, "opencv_highgui247d.lib")
#pragma comment(lib, "opencv_ml247d.lib")
//#pragma comment(lib, "opencv_stitching247d.lib");
//#pragma comment(lib, "opencv_nonfree247d.lib");
#pragma comment(lib, "opencv_video247d.lib")
#else
#pragma comment(lib, "opencv_core247.lib")
#pragma comment(lib, "opencv_imgproc247.lib")
#pragma comment(lib, "opencv_objdetect247.lib")
#pragma comment(lib, "opencv_gpu247.lib")
//#pragma comment(lib, "opencv_features2d247.lib")
#pragma comment(lib, "opencv_highgui247.lib")
#pragma comment(lib, "opencv_ml247.lib")
//#pragma comment(lib, "opencv_stitching247.lib");
//#pragma comment(lib, "opencv_nonfree247.lib");
#pragma comment(lib, "opencv_video247d.lib")
#endif 

using namespace cv;
using namespace std;


void drawOptFlowMap_gpu (const Mat& flow_x, const Mat& flow_y, Mat& cflowmap, int step, const Scalar& color) {

 

 for(int y = 0; y < cflowmap.rows; y += step)
        for(int x = 0; x < cflowmap.cols; x += step)
        {
   Point2f fxy; 
   fxy.x = cvRound( flow_x.at< float >(y, x) + x );
   fxy.y = cvRound( flow_y.at< float >(y, x) + y );
   
   line(cflowmap, Point(x,y), Point(fxy.x, fxy.y), color);
   circle(cflowmap, Point(fxy.x, fxy.y), 1, color, -1);
        }
}



int main()
{
 //resize scale
 int s=4;

 unsigned long AAtime=0, BBtime=0;

 //variables
 Mat GetImg, flow_x, flow_y, next, prvs;
 
 //gpu variable
 gpu::GpuMat prvs_gpu, next_gpu, flow_x_gpu, flow_y_gpu;
 gpu::GpuMat prvs_gpu_o, next_gpu_o;
 gpu::GpuMat prvs_gpu_c, next_gpu_c;

 //file name
 char fileName[100] = ".\\mm2.avi"; //Gate1_175_p1.avi"; //video\\mm2.avi"; //mm2.avi"; //cctv 2.mov"; //mm2.avi"; //";//_p1.avi";
 //video file open
 VideoCapture stream1(fileName);   //0 is the id of video device.0 if you have only one camera   
 if(!(stream1.read(GetImg))) //get one frame form video
  return 0;



 //////////////////////////////////////////////////////////////////////////////////////////////
 //resize(GetImg, prvs, Size(GetImg.size().width/s, GetImg.size().height/s) );
 //cvtColor(prvs, prvs, CV_BGR2GRAY);
 //prvs_gpu.upload(prvs);
 //////////////////////////////////////////////////////////////////////////////////////////////
 //gpu upload, resize, color convert
 prvs_gpu_o.upload(GetImg);
 gpu::resize(prvs_gpu_o, prvs_gpu_c, Size(GetImg.size().width/s, GetImg.size().height/s) );
 gpu::cvtColor(prvs_gpu_c, prvs_gpu, CV_BGR2GRAY);
 /////////////////////////////////////////////////////////////////////////////////////////////

 //dense optical flow
 gpu::FarnebackOpticalFlow fbOF;

 //unconditional loop   
 while (true) {   
  
  if(!(stream1.read(GetImg))) //get one frame form video   
   break;

  ///////////////////////////////////////////////////////////////////
  //resize(GetImg, next, Size(GetImg.size().width/s, GetImg.size().height/s) );
  //cvtColor(next, next, CV_BGR2GRAY);
  //next_gpu.upload(next);
  ///////////////////////////////////////////////////////////////////
  //gpu upload, resize, color convert
  next_gpu_o.upload(GetImg);
  gpu::resize(next_gpu_o, next_gpu_c, Size(GetImg.size().width/s, GetImg.size().height/s) );
  gpu::cvtColor(next_gpu_c, next_gpu, CV_BGR2GRAY);
  ///////////////////////////////////////////////////////////////////

  AAtime = getTickCount();
  //dense optical flow
  fbOF.operator()(prvs_gpu, next_gpu, flow_x_gpu, flow_y_gpu);
  //fbOF(prvs_gpu, next_gpu, flow_x_gpu, flow_y_gpu);
  BBtime = getTickCount();
  float pt = (BBtime - AAtime)/getTickFrequency();
  float fpt = 1/pt;
  printf("%.2lf / %.2lf \n",  pt, fpt );

  //copy for vector flow drawing
  Mat cflow;
  resize(GetImg, cflow, Size(GetImg.size().width/s, GetImg.size().height/s) );
  flow_x_gpu.download( flow_x );
  flow_y_gpu.download( flow_y );
  drawOptFlowMap_gpu(flow_x, flow_y, cflow, 10 , CV_RGB(0, 255, 0));
  imshow("OpticalFlowFarneback", cflow);

  ///////////////////////////////////////////////////////////////////
  //Display gpumat
  next_gpu.download( next );
  prvs_gpu.download( prvs );
  imshow("next", next );
  imshow("prvs", prvs );

  //prvs mat update
  prvs_gpu = next_gpu.clone();
  
  if (waitKey(5) >= 0)   
   break;
 }
}



