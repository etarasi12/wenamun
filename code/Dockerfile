# Linux container build for rendering Egyption Hieroglyphic
# transcription with JSesh.

FROM debian:12 AS java

# Install the build environment
RUN apt-get update
RUN apt-get install -y git openjdk-17-jdk-headless maven

# Check out jsesh
RUN git clone https://github.com/rillian/jsesh.git
WORKDIR jsesh

# Use the branch we need
RUN git switch MDCToPNG
RUN mvn package

# There's no linux install target; manually copy the parts we need
RUN mkdir /opt/jsesh/
RUN cp jseshDemos/target/jseshDemos-7.6.0-SNAPSHOT.jar /opt/jsesh/
RUN cp jsesh/target/jsesh-7.6.0-SNAPSHOT.jar /opt/jsesh/
RUN cp jseshGlyphs/target/jseshGlyphs-7.6.0-SNAPSHOT.jar /opt/jsesh/
RUN cp cupruntime/target/cupruntime-7.6.0-SNAPSHOT.jar /opt/jsesh/
RUN cp qenherkhopeshefUtils/target/qenherkhopeshefUtils-7.6.0-SNAPSHOT.jar /opt/jsesh/

FROM debian:12 AS render

RUN apt-get update
RUN apt-get install -y openjdk-17-jre-headless
RUN apt-get install -y git python3 python3-pil

COPY --from=java /opt/jsesh /opt/jsesh

RUN git clone https://github.com/tansebe/wenamun.git
WORKDIR wenamun/code

ADD render.sh .

CMD /bin/sh render.sh
