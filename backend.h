#ifndef BACKEND_H
#define BACKEND_H

#include <QQuickItem>

class Backend : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(qreal delta READ delta WRITE setDelta NOTIFY deltaChanged)

public:
    Backend();

    qreal delta() const {return m_delta;}
    void setDelta(qreal delta){
        m_delta = delta;
        emit deltaChanged();
    }

signals:
    void deltaChanged();

public slots:

private:
    qreal m_delta;
};

#endif // BACKEND_H
