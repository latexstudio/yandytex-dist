return {

    type    = "configuration",
    version = "1.1.0",
    date    = "2011-09-02", -- or so
    time    = "12:12:12",
    comment = "ConTeXt MkIV configuration file",
    author  = "Hans Hagen, PRAGMA-ADE, Hasselt NL",

    content = {

        -- Originally there was support for engines and progname but I don't expect
        -- other engines to use this file, so first engines were removed. After that
        -- if made sense also to get rid of progname. At some point specific formats
        -- will be supported but then as a subtable with fallbacks, which sounds more
        -- natural. Also, at some point the paths will become tables. For the moment
        -- I don't care too much about it as extending is easy.

        variables = {

            -- The following variable is predefined (but can be overloaded) and in
            -- most cases you can leve this one untouched. The built-in definition
            -- permits relocation of the tree.
            --
            -- TEXMFCNF     = "{selfautodir:,selfautoparent:}{,{/share,}/texmf{-local,}/web2c}"
            --
            -- more readable than "selfautoparent:{/texmf{-local,}{,/web2c},}}" is:
            --
            -- TEXMFCNF     = {
            --     "selfautoparent:/texmf-local",
            --     "selfautoparent:/texmf-local/web2c",
            --     "selfautoparent:/texmf-dist",
            --     "selfautoparent:/texmf-dist/web2c",
            --     "selfautoparent:",
            -- }

            -- We have only one cache path but there can be more. The first writable one
            -- will be chose but there can be more readable paths.

            TEXMFCACHE      = "$SELFAUTODIR/share/ctxdir",

            -- I don't like this texmf under home and texmf-home would make more
            -- sense. One never knows what installers put under texmf anywhere and
            -- sorting out problems will be a pain. But on the other hand ... home
            -- mess is normally under the users own responsibility.
            --
            -- By using prefixes we don't get expanded paths in the cache __path__
            -- entry. This makes the tex root relocatable.

            TEXMFOS         = "selfautodir:",
            TEXMFSYSTEM     = "selfautodir:share/texmf-$SELFAUTOSYSTEM",
            TEXMFMAIN       = "selfautodir:share/texmf-dist",
            TEXMFCONTEXT    = "selfautodir:share/texmf-context",
            TEXMFLOCAL      = "selfautodir:share/texmf-local",
            TEXMFFONTS      = "selfautodir:share/texmf-fonts",
            TEXMFPROJECT    = "selfautodir:share/texmf-project",

            TEXMFHOME       = "home:texmf",
         -- TEXMFHOME       = os.name == "macosx" and "home:Library/texmf" or "home:texmf",

            -- We need texmfos for a few rare files but as I have a few more bin trees
            -- a hack is needed. Maybe other users also have texmf-platform-new trees.

            TEXMF           = "{$TEXMFHOME,$TEXMFLOCAL,$TEXMFMAIN,$TEXMFPROJECT,$TEXMFFONTS,$TEXMFCONTEXT,$TEXMFSYSTEM}",

            TEXFONTMAPS     = ".;$TEXMF/fonts/data//;$TEXMF/fonts/map/{pdftex,dvips}//",
            ENCFONTS        = ".;$TEXMF/fonts/data//;$TEXMF/fonts/enc/{dvips,pdftex}//",
            VFFONTS         = ".;$TEXMF/fonts/{data,vf}//",
            TFMFONTS        = ".;$TEXMF/fonts/{data,tfm}//",
            T1FONTS         = ".;$TEXMF/fonts/{data,type1,pfb}//;$OSFONTDIR",
            AFMFONTS        = ".;$TEXMF/fonts/{data,afm}//;$OSFONTDIR",
            TTFONTS         = ".;$TEXMF/fonts/{data,truetype,ttf}//;$OSFONTDIR",
            OPENTYPEFONTS   = ".;$TEXMF/fonts/{data,opentype}//;$OSFONTDIR",
            CMAPFONTS       = ".;$TEXMF/fonts/cmap//",
            FONTFEATURES    = ".;$TEXMF/fonts/{data,fea}//;$OPENTYPEFONTS;$TTFONTS;$T1FONTS;$AFMFONTS",
            FONTCIDMAPS     = ".;$TEXMF/fonts/{data,cid}//;$OPENTYPEFONTS;$TTFONTS;$T1FONTS;$AFMFONTS",
            OFMFONTS        = ".;$TEXMF/fonts/{data,ofm,tfm}//",
            OVFFONTS        = ".;$TEXMF/fonts/{data,ovf,vf}//",

            TEXINPUTS       = ".;{$CTXDEVTXPATH};$TEXMF/tex/{context,plain/base,generic}//",
            MPINPUTS        = ".;{$CTXDEVMPPATH};$TEXMF/metapost/{context,base,}//",

            -- In the next variable the inputs path will go away.

            TEXMFSCRIPTS    = ".;$CTXDEVLUPATH;$CTXDEVRBPATH;$CTXDEVPLPATH;$TEXMF/scripts/context/{lua,ruby,python,perl}//;$TEXINPUTS",
            PERLINPUTS      = ".;$CTXDEVPLPATH;$TEXMF/scripts/context/perl",
            PYTHONINPUTS    = ".;$CTXDEVPYPATH;$TEXMF/scripts/context/python",
            RUBYINPUTS      = ".;$CTXDEVRBPATH;$TEXMF/scripts/context/ruby",
            LUAINPUTS       = ".;$CTXDEVLUPATH;$TEXINPUTS;$TEXMF/scripts/context/lua//",
            CLUAINPUTS      = ".;$SELFAUTOLOC/lib/{context,luatex,}/lua//",

            -- Not really used by MkIV so they might go away.

            BIBINPUTS       = ".;{$CTXDEVTXPATH};$TEXMF/bibtex/bib//",
            BSTINPUTS       = ".;{$CTXDEVTXPATH};$TEXMF/bibtex/bst//",

            -- Experimental

            ICCPROFILES     = ".;$TEXMF/colors/icc/{context,profiles}//;$OSCOLORDIR",

            -- A few special ones that will change some day.

            FONTCONFIG_FILE = "fonts.conf",
            FONTCONFIG_PATH = "$TEXMFMAIN/fonts/conf",
            FC_CACHEDIR     = "$TEXMFMAIN/fonts/cache", -- not needed

        },

        -- We have a few reserved subtables. These control runtime behaviour. The
        -- keys have names like 'foo.bar' which means that you have to use keys
        -- like ['foo.bar'] so for convenience we also support 'foo_bar'.

        directives = {

            -- There are a few variables that determine the engines
            -- limits. Most will fade away when we close in on version 1.

            ["luatex.expanddepth"]       =  "10000", -- 10000
            ["luatex.hashextra"]         = "100000", --     0
            ["luatex.nestsize"]          =   "1000", --    50
            ["luatex.maxinopen"]         =    "500", --    15
            ["luatex.maxprintline"]      = " 10000", --    79
            ["luatex.maxstrings"]        = "500000", -- 15000 -- obsolete
            ["luatex.paramsize"]         =  "25000", --    60
            ["luatex.savesize"]          =  "50000", --  4000
            ["luatex.stacksize"]         =  "10000", --   300

            -- A few process related variables come next.

         -- ["system.checkglobals"]      = "10",
         -- ["system.nostatistics"]      = "yes",
            ["system.errorcontext"]      = "10",
            ["system.compile.cleanup"]   = "no",    -- remove tma files
            ["system.compile.strip"]     = "yes",   -- strip tmc files

            -- The io modes are similar to the traditional ones. Possible values
            -- are all, paranoid and restricted.

            ["system.outputmode"]        = "restricted",
            ["system.inputmode"]         = "any",

            -- The following variable is under consideration. We do have protection
            -- mechanims but it's not enabled by default.

            ["system.commandmode"]       = "any", -- any none list
            ["system.commandlist"]       = "mtxrun, convert, inkscape, gs, imagemagick, curl, bibtex, pstoedit",

            -- The mplib library support mechanisms have their own
            -- configuration. Normally these variables can be left as
            -- they are.

            ["mplib.texerrors"]          = "yes",

            -- Normally you can leave the font related directives untouched
            -- as they only make sense when testing.

         -- ["fonts.autoreload"]         = "no",
         -- ["fonts.otf.loader.method"]  = "table", -- table mixed sparse
         -- ["fonts.otf.loader.cleanup"] = "0",     -- 0 1 2 3

            -- In an edit cycle it can be handy to launch an editor. The
            -- preferred one can be set here.

         -- ["pdfview.method"]           = "okular", -- default (often acrobat) xpdf okular

        },

        experiments = {
            ["fonts.autorscale"] = "yes",
        },

        trackers = {
        },

    },

    TEXMFCACHE  = "$SELFAUTODIR/share/ctxdir", -- for old times sake

}
