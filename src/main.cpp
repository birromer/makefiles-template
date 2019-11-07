#include <opencv2/opencv.hpp>
#include <opencv2/xfeatures2d.hpp>
#include <opencv2/features2d.hpp>

const int MAX_FEATURES= 500;
const float GOOD_MATCH_PERCENT = 0.15f;

//using namespace std;
//using namespace cv;
//using namespace cv::xfeatures2d;


int main(int argc, char *argv[])
{
    // Read the image to detect keypoints
    std::string refFileName = argv[1];
    cv::Mat imReference = cv::imread(refFileName);

    // Convert image to grayscle
    cv::Mat imGray;
    cvtColor(imReference, imGray, cv::COLOR_BGR2GRAY);

    // Detect ORB features and compute descriptors
    std::vector<cv::KeyPoint> keypoints;
    cv::Mat descriptors;
    cv::Ptr<cv::Feature2D> orb = cv::ORB::create(MAX_FEATURES);
    orb->detectAndCompute(imGray, cv::Mat(), keypoints, descriptors);

    // Draw keypoints
    cv::Mat img_keypoints;
    drawKeypoints (imGray, keypoints, img_keypoints);

    // Show image with keypoints
    cv::imshow("ORB Keypoints", img_keypoints);


    cv::waitKey();

    // for (int i=0; i < keypoints.size(); i++)
    //     std::cout << keypoints[i].pt << std::endl;

//    std::cout << imGray.size();

    return 0;
}
