#ifndef TEXTFILE_HPP
#define TEXTFILE_HPP

#include <QtCore/QObject>
#include <QtCore/QFile>
#include <QString>
#include <QDebug>

class TextFile : public QObject
{   Q_OBJECT
public slots:
    QString load(const QString& path)
    {
        QFile f(path);
        if (!f.open(QIODevice::ReadOnly | QIODevice::Text)) {
            qDebug() << "File " + path + " can not be read" ;
            return QString();
        }
        QString data(QString::fromUtf8(f.readAll()));
        f.close();
        qDebug() << "Text loading: " + data ;
        return data;
    }
};

#endif // TEXTFILE_HPP
