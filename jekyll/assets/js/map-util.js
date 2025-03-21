---
## required to process the handlebars
---
function popUp(feature, layer) {
    var out = [];
    if (feature.properties) {
        for (key in feature.properties) {
            out.push(key + ": " + feature.properties[key]);
        }

        layer.bindPopup(out.join("<br />"));
    }
}

/*
Return a Promise that's fulfilled when the GPX file is loaded.
*/
function loadGpx(gpx, _map) {
    return new Promise((resolve) => {
        // https://unpkg.com/randomcolor@0.5.3/randomColor.js

        var g = new L.GPX(
            gpx,
            {
                async: true,
                marker_options: {
                    startIconUrl: null,
                    startIcon: null,
                    endIconUrl: null,
                    endIcon: null,

                    shadowUrl: null,
                    wptIconUrls: null,
                }
            }
        );

        g.addEventListener("loaded", (evt) => {
            resolve(evt);
        });

        g.addTo(_map);
    });
}

function addPhotoToGroup(group, img, postUrl, postTitle) {
    var base_url = "{{ site.static_images_base_url }}";

    var popupImgUrl = base_url + "/fit-in/400x/" + img.path;
    var iconUrls = [
        base_url + "/fit-in/50x50/" + img.path,
        base_url + "/fit-in/75x75/" + img.path
    ];

    group.addLayer(
        L.marker(
            [ img.exif.location.latitude, img.exif.location.longitude ],
            {
                title: postTitle + " - " + img.exif.location.name,
                icon: L.icon({
                    _iconUrls: iconUrls,
                    iconUrl: iconUrls[0],
                    className: "photo-marker-icon",
                })
            }
        ).bindPopup(
            '<img src="' + popupImgUrl + '" alt="image" /><br />' +
            '<a href="' + postUrl + '">' + postTitle + '</a>',
            {
                maxWidth: 400,
                minWidth: 400
            }
        )
    );
}
