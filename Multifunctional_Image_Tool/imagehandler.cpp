#include "imagehandler.h"
#include <QGraphicsObject>
#include <QImage>
#include <QPainter>
#include <QStyleOptionGraphicsItem>
#include <QDebug>
#include <QFileInfo>

ImageHandler::ImageHandler(QString providerName, QObject *parent) :
    QObject(parent),
    QQuickImageProvider(QQuickImageProvider::Image),
    _providerName(providerName)
{
}

QString ImageHandler::providerName()
{
    return _providerName;
}

QImage ImageHandler::extractQImage(QObject *imageObj,
                                   const double offsetX, const double offsetY,
                                   const double width, const double height)
{
    QGraphicsObject *item = qobject_cast<QGraphicsObject*>(imageObj);

    if (!item) {
        qDebug() << "Item is NULL";
        return QImage();
    }

    QImage img(item->boundingRect().size().toSize(), QImage::Format_RGB32);
    img.fill(QColor(255, 255, 255).rgb());
    QPainter painter(&img);
    QStyleOptionGraphicsItem styleOption;
    item->paint(&painter, &styleOption);

    if(offsetX == 0 && offsetY == 0 && width == 0 && height == 0)
        return img;
    else
    {
        return img.copy(offsetX, offsetY, width, height);
    }
}

void ImageHandler::save(QObject *imageObj, const QString &path,
                        const double offsetX, const double offsetY,
                        const double width, const double height)
{
    QImage img = extractQImage(imageObj, offsetX, offsetY, width, height);
    img.save(path);
}

bool ImageHandler::imageFileExists(const QString &path)
{
    return QFileInfo(path).exists();
}

void ImageHandler::makeImageAvailable(const QImage image, const QString& uniqueName)
{
    imageRepository[uniqueName] = image;
}

void ImageHandler::removeImage(const QString& uniqueName)
{
    if(imageRepository.contains(uniqueName))
        imageRepository.remove(uniqueName);
}

QImage ImageHandler::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    QImage* selectedImage = NULL;
    if(imageRepository.contains(id))
        selectedImage = &imageRepository[id];
    else
        selectedImage = new QImage(requestedSize, QImage::Format_ARGB32);

    if(size)
        *size = QSize(selectedImage->width(), selectedImage->height());

    return *selectedImage;
}
