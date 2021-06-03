#ifndef NEWMODEL_H
#define NEWMODEL_H

#include <QAbstractListModel>
#include <vector>



class NewModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int m_size READ size WRITE setSize NOTIFY sizeChanged)
    Q_PROPERTY(bool canFlip READ getCanFlip)
    Q_PROPERTY(int openCard READ getOpenCard)
    Q_PROPERTY(int point READ getPoint NOTIFY pointChange)

    struct CardItems{
        int id;
        bool isFlip;
        bool visible;
        QString picture;
//        bool operator==(const int otheid){
//            return otheid == id;
//        }
    };

public:
    explicit NewModel(QObject *parent = nullptr);
    enum{
        idRole = Qt::UserRole,
        isFlipRole,
        visibleRole,
        pictureRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash <int, QByteArray> roleNames() const override;

   int getBoardWidth() const;

   //Engine
   int size() const;
   Q_INVOKABLE void setSize(int size);
   Q_INVOKABLE bool moveV(int id);
   Q_INVOKABLE void checkAndDo();

   void StartGame();  
   bool getCanFlip() const;
   int getOpenCard() const;
   int getPoint() const;

signals:
   int sizeChanged();
   int flipBack(int ind);
   void pointChange();
   void endGame();

private:
    bool canFlip = true;
    int m_size = 6;
    int openCard = 0;
    int point = 0;
    int fist = -1;
    int second = -1;
    std::vector<CardItems> m_Cards;
};

#endif // NEWMODEL_H
