#include "stdafx.h"
#include "AStar.h"


// 前四个是上下左右（逆时针），后四个是斜角
//int AStarPathFind::dx[] = { 0, -1, 0, 1, -1, -1, 1, 1 };
//int AStarPathFind::dy[] = { -1, 0, 1, 0, 1, -1, -1, 1 };

//顺时针，上，左，下，右
int AStarPathFind::dx[] = { 0, 1, 0, -1, -1, -1, 1, 1 };
int AStarPathFind::dy[] = { -1, 0, 1, 0, 1, -1, -1, 1 };

// 最外圈都是1表示不可通过
int AStarPathFind::map[][15] = {
	{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 } 
};


stack<PointEx*>* AStarPathFind::printPath(PointEx start, PointEx end) 
{
	/*
	* 不用PriorityQueue是因为必须取出存在的元素
	*/
	deque<PointEx*> openTable;
	deque<PointEx*> closeTable;
	openTable.clear();
	closeTable.clear();
	stack<PointEx*>* pathStack = new stack<PointEx*>;
	start.parent = NULL;
	//该点起到转换作用，就是当前扩展点
	PointEx* currentPoint = new PointEx(start.x, start.y);
	PointEx* pEnd = new PointEx(end.x, end.y);

	//closeTable.add(currentPoint);
	bool flag = true;

	while(flag) 
	{
		for (int i = 0; i < 8; i++) 
		{
			int fx = currentPoint->x + dx[i];
			int fy = currentPoint->y + dy[i];
			PointEx* tempPoint = new PointEx(fx,fy);
			if (map[fx][fy] == 1) 
			{
				// 由于边界都是1中间障碍物也是1，，这样不必考虑越界和障碍点扩展问题
				//如果不设置边界那么fx >=map.length &&fy>=map[0].length判断越界问题
				continue;
			}
			else 
			{
				if(pEnd->equals(*tempPoint)) 
				{
					flag = false;
					//不是tempPoint，他俩都一样了此时
					pEnd->parent = currentPoint;
					break;
				}
				if(i<4) 
				{
					tempPoint->G = currentPoint->G + 10;
				}else 
				{
					tempPoint->G = currentPoint->G + 14;
				}
				tempPoint->H = PointEx::getDis(*tempPoint,end);
				tempPoint->F = tempPoint->G + tempPoint->H;
				//因为重写了equals方法，所以这里包含只是按equals相等包含
				//这一点是使用java封装好类的关键
				//if(openTable.contains(tempPoint)) 
				
				deque<PointEx*>::iterator it = find_if(openTable.begin(), openTable.end(), *tempPoint);
				deque<PointEx*>::iterator itClosed = find_if(closeTable.begin(), closeTable.end(), *tempPoint);
				if( it != openTable.end())
				{           
					//int pos = openTable.indexOf(tempPoint );
					//Point temp = openTable.get(pos);
					PointEx* temp = *it;
					if( tempPoint->F < temp->F ) 
					{
						//openTable.remove(pos);
						//openTable.add(tempPoint);
						openTable.erase(it);
						openTable.push_back(tempPoint);

						tempPoint->parent = currentPoint;
					}
				}
				else if(itClosed != closeTable.end() )
				{
					//int pos = closeTable.indexOf(tempPoint );
					//Point temp = closeTable.get(pos);
					PointEx* temp = *itClosed;
					if( tempPoint->F < temp->F ) 
					{
						//closeTable.remove(pos);
						//openTable.add(tempPoint);
						closeTable.erase(itClosed);
						openTable.push_back(tempPoint);
						tempPoint->parent = currentPoint;
					}
				}else
				{
					//openTable.add(tempPoint);
					openTable.push_back(tempPoint);
					tempPoint->parent = currentPoint;
				}

			}
		}//end for

		if(openTable.empty()) 
		{
			return NULL;
		}//无路径
		if(false==flag) 
		{
			break;
		}//找到路径
		
		//openTable.remove(currentPoint);
		//closeTable.add(currentPoint);
		//Collections.sort(openTable);
		//currentPoint = openTable.get(0);		
		
		//deque<PointEx*>::iterator it = find_if(openTable.begin(), openTable.end(), *currentPoint);
		//if( it != openTable.end() )
		//	openTable.erase(it);
		remove_if(openTable.begin(), openTable.end(), *currentPoint);
		closeTable.push_back(currentPoint);
		currentPoint = openTable.front();
		openTable.pop_front();
	}//end while
	PointEx* node = pEnd;
	while(node->parent!=NULL) 
	{
		pathStack->push(node);
		node = node->parent;
	}    
	return pathStack;
}
