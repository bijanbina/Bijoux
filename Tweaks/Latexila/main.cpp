#include <QCoreApplication>
#include <zlib.h>
#include <QDebug>
#include <QString>
#include <QFile>
#include <QDir>

#define LATEXILA_SRC "/home/bijan/Project/TEMP/gnome-icon-theme-symbolic-master/latexila-3.20.1"

int changePallet(QString filename)
{
    int last_offset = 0,pallet_offset = 0;
    bool canRead;
    char byte;

    QFile *file = new QFile(filename);
    file->open(QIODevice::ReadWrite);
    canRead = file->getChar(&byte);
    while (canRead)
    {
        canRead = file->getChar(&byte);
        if (byte == 'P' && canRead)
        {
            canRead = file->getChar(&byte);
            if(byte == 'L' && canRead)
            {
                canRead = file->getChar(&byte);
                if(byte == 'T' && canRead)
                {
                    canRead = file->getChar(&byte);
                    if(byte == 'E' && canRead)
                    {
                        pallet_offset = last_offset;
                        //qDebug() << "We found it at " << QString::number(last_offset,16);
                        break;
                    }
                    else
                    {
                        file->seek(last_offset+1);
                    }
                }
                else
                {
                    file->seek(last_offset+1);
                }
            }
             else
            {
                file->seek(last_offset+1);
            }
        }
        last_offset++;
    }
    if (canRead)
    {
        file->seek(last_offset-1);
        file->getChar(&byte);
        int size = (unsigned char)byte;
        //qDebug() << "size is " << size;
        //qDebug() << byte;
        unsigned char data_address[110];
        int len = size + 4;
        data_address[0] = 0x50;
        data_address[1] = 0x4C;
        data_address[2] = 0x54;
        data_address[3] = 0x45;

        for(int i = 4;i<len;i++)
        {
            data_address[i] = 0xFF;
        }
        unsigned long  crc = crc32(0L, Z_NULL, 0);
        crc = crc32(crc, (unsigned char *)data_address, len);
        char *crc_p = (char *)&crc;
        //qDebug() << QString::number(crc,16);
        file->write((char *)data_address,len);
        file->putChar(crc_p[3]);
        file->putChar(crc_p[2]);
        file->putChar(crc_p[1]);
        file->putChar(crc_p[0]);
    }
    else
    {
        qDebug() << "Detected: " << filename;
    }
    file->close();
    delete file;
    return 0;
}

int changePallet_dir(QString dir_name)
{
    QString filename;
    QDir myDir(dir_name);
    QStringList filesList = myDir.entryList(QStringList("*.png"));
    for (int i = 0;i<filesList.size();i++)
    {
        filename = dir_name + filesList[i];
        changePallet(filename);
    }
    qDebug() << "done " << dir_name;
    return 0;
}

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    changePallet_dir(LATEXILA_SRC"/images/arrows/");
    changePallet_dir(LATEXILA_SRC"/data/images/delimiters/");
    changePallet_dir(LATEXILA_SRC"/data/images/greek/");
    changePallet_dir(LATEXILA_SRC"/data/images/misc-math/");
    changePallet_dir(LATEXILA_SRC"/data/images/misc-text/");
    changePallet_dir(LATEXILA_SRC"/data/images/operators/");
    changePallet_dir(LATEXILA_SRC"/data/images/relations/");
    changePallet_dir(LATEXILA_SRC"/data/icons/24x24/actions/");
    return 0;
}
