# Use Chainguard Wolfi as the base
FROM cgr.dev/chainguard/wolfi-base:latest

# Install dependencies
RUN apk add --no-cache git gcc make gmp-dev bash

# Clone and build ATS2
RUN git clone --depth 1 https://github.com/githwxi/ATS-Postiats.git \
    && cd ATS-Postiats \
    && autoconf \
    && ./configure \
    && make \
    && make install

# Copy your TUI source
COPY ats2_tui.dats /app/

# Build your TUI
RUN atscc /app/ats2_tui.dats -o /app/ats2-tui

# Run the TUI
CMD ["/app/ats2-tui"]
