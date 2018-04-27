#include <stdio.h>
#include <vector>
#include <stack>
#include <math.h>
#include <string>
#include <algorithm>
#include <queue>
#include <map>
using namespace std;


class PointEx
{
public:
	int x;
	int y;
	PointEx* parent;
	int F, G, H;

	int visited;
	int inOpen;
	int inClosed;

	PointEx(int x, int y) 
	{		
		this->x = x;
		this->y = y;
		F = 0;
		G = 0;
		H = 0;
		parent = NULL;
		visited = 0;
		inOpen = 0;
		inClosed = 0;
	}


	bool operator()(PointEx* pt)
	{
		return equals(*pt);
	}

	bool operator==(PointEx* pt)
	{
		return equals(*pt);
	}
	bool operator()(const PointEx& pt)
	{
		return equals(pt);
	}

	
	int compareTo(PointEx o) {
		// TODO Auto-generated method stub
		return F  - o.F;
	}

	bool equals(PointEx point) {		
		if (point.x == x && point.y == y)
			return true;
		return false;
	}

	static int getDis(PointEx p1, PointEx p2) {
		int dis = abs(p1.x - p2.x) * 10 + abs(p1.y - p2.y) * 10;
		return dis;
	}

	string toString() {
		char szTemp[256] = {0,};
		sprintf(szTemp, "(%d,%d)", this->x, this->y);
		return string(szTemp);
		//return "(" + this.x + "," + this.y + ")";
	}
};

//class lessPointEx
//{
//	bool operator()(const PointEx& left, const PointEx& right)
//	{
//		return left < right;
//	}
//};

class AStarPathFind
{
	static int dx[];
	static int dy[];
	static int mapInfo[][53];
public:
	AStarPathFind()
	{	
	}

	static stack<PointEx*>* printPath(PointEx start, PointEx end);
};
