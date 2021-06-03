#include "newmodel.h"
#include "QDebug"

#include <bitset>
#include <random>


NewModel::NewModel(QObject *parent)
    : QAbstractListModel(parent)
{
    // Fist initial
    StartGame();
}

bool NewModel::moveV(int ind)
{
    if(canFlip && openCard < 2){
        ++openCard;
        m_Cards[ind].isFlip = true;
        canFlip = openCard < 2 ? true: false;
        if(openCard == 1) {fist =  ind;}
     else if(openCard == 2) second = ind;
    }
    emit dataChanged(createIndex(0,0), createIndex(m_size, 0));
    return true;
}

void NewModel::checkAndDo()
{
    if (openCard == 2) {
        if (m_Cards[fist].id == m_Cards[second].id){
            // Очки ++
            ++point;
            emit pointChange();
            m_Cards[fist].visible = false;
            m_Cards[second].visible = false;
            emit dataChanged(createIndex(0,0), createIndex(m_size, 0));
            canFlip = true;
            openCard = 0;
            if (point == m_size/2) {
                point = 0;
                emit endGame();
            }

        } else {
            m_Cards[fist].isFlip = false;
            m_Cards[second].isFlip = false;
            emit flipBack(fist);
            emit flipBack(second);
            emit dataChanged(createIndex(0,0), createIndex(m_size, 0));
            openCard = 0;
            canFlip = true;
        }
    }
}

int NewModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_Cards.size();
}

QVariant NewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const CardItems item = m_Cards.at(index.row());

    switch (role) {
    case idRole:
        return QVariant(item.id);
    case isFlipRole:
        return QVariant(item.isFlip);
    case visibleRole:
        return QVariant(item.visible);
    case pictureRole:
        return QVariant(item.picture);
    }
    return QVariant();
}

bool NewModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags NewModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> NewModel::roleNames() const
{
    qDebug() << "Enter in roleName" << Qt::endl;
    QHash<int, QByteArray> names;
    names[idRole] = "id";
    names[isFlipRole] = "isFlip";
    names[visibleRole] = "visible";
    names[pictureRole] = "picture";
    return names;
}

int NewModel::size() const
{
    return m_size;
}

void NewModel::setSize(int size)
{
    m_size = size;
    emit sizeChanged();
    StartGame();
}

void NewModel::StartGame()
{
    // Отчистка массива и прочих значений
    m_Cards.clear();
    openCard = 0;
    canFlip = true;

    //Заполнение массива значениями карты
    static auto seed = std::chrono::system_clock::now().time_since_epoch().count();
    static std::mt19937 generator(seed);

    std::srand(std::time(nullptr));
    std::bitset<24> cardPic = 0;
    while (cardPic.count() != m_size/2) {
        int x;
        x = generator()%24;
        if (!cardPic.test(x)){
            cardPic.set(x);
            QString path = QString("qrc:/pic/%1.png").arg(x);
            //qDebug() << path;
            m_Cards.push_back({ x, false, true, path });
            m_Cards.push_back({ x, false, true, path });

        }
    }
    // Перетасовка массива
    std::shuffle(m_Cards.begin(), m_Cards.end(), generator);

}

bool NewModel::getCanFlip() const
{
    return canFlip;
}

int NewModel::getOpenCard() const
{
    return openCard;
}

int NewModel::getPoint() const
{
    return point;
}


