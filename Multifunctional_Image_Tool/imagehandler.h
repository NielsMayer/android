#ifndef IMAGEHANDLER_H
#define IMAGEHANDLER_H

#include <QQuickImageProvider>
#include <QImage>
#include <QMap>

class ImageHandler : public QObject, public QQuickImageProvider
{
    Q_OBJECT
public:
    explicit ImageHandler(QString providerName, QObject *parent = 0);

    QString providerName();

    /**
      * The method through which the images are provided
      */
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);

public slots:
    /**
      * Called from QML. Argument imageObj is the Image QML element.
      * The rest define the geometry of the portion that is to be
      * acquired.
      */
    QImage extractQImage(QObject *imageObj,
                         const double offsetX, const double offsetY,
                         const double width, const double height);

    /**
      * Called from QML. Argument imageObj is the Image QML element.
      * path is the actual path that the image provided will be saved
      * The rest define the geometry of the portion of the image that
      * is to be acquired.
      */
    void save(QObject *item, const QString &path,
              const double offsetX = 0, const double offsetY = 0,
              const double width = 0, const double height = 0);

    /**
      * Returns whether the file pointed by the path already exists
      */
    bool imageFileExists(const QString &path);

    /**
      * Add a QImage to the image repository to make it accesible from QML
      */
    void makeImageAvailable(const QImage image, const QString& uniqueName);

    /**
      * Remove a previously added image from repository. This will make image
      * inaccessible from QML.
      */
    void removeImage(const QString& uniqueName);

private:
    QMap<QString, QImage> imageRepository;
    QString _providerName;
};

#endif // IMAGEHANDLER_H
